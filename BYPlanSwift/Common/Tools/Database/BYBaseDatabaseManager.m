//
//  BYBaseDatabaseManager.m
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/11.
//

#import "BYBaseDatabaseManager.h"
#import <sqlite3.h>
#import <pthread.h>
#import <objc/runtime.h>


#define BYSafeEmptyString(value) ((value)?(value):@"")

static NSString * kDBVersionKey = @"DB_Version_Key";

@interface BYBaseDatabaseManager (){
    pthread_mutex_t _dbLock;
    FMDatabaseQueue *_databaseQueue;
}

@property (nonatomic, copy) NSString * dbFilePath;

@end

@implementation BYBaseDatabaseManager

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_dbLock, NULL);
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(p_receiveMemoryWarning)
         name:UIApplicationDidReceiveMemoryWarningNotification
         object:nil];
    }
    return self;
}

- (void)dealloc{
    pthread_mutex_destroy(&_dbLock);
}

// MARK: - ---- Public method
/// 设置数据库文件路径和版本
- (void)setDbFilePath:(NSString *)dbFilePath newDbVersion:(NSString*)newDbVersion {
    // 设置数据库文件路径
    _dbFilePath = dbFilePath;
    [[NSFileManager defaultManager] setAttributes:[NSDictionary dictionaryWithObject:NSFileProtectionNone forKey:NSFileProtectionKey] ofItemAtPath:dbFilePath error:NULL];
    [self p_versionControlWithNewDBVersion:newDbVersion];
}

// MARK: - Override
/// 初始化数据表，子类需要重写该方法
-(void)initTables {
    
}

// MARK: - ---- Private
/// 释放资源
- (void)p_receiveMemoryWarning{
    pthread_mutex_lock(&_dbLock);
    _databaseQueue = nil;
    pthread_mutex_unlock(&_dbLock);
}

///  数据库版本
- (void)p_setDbVersion:(NSString*)dbVersion {
    [[NSUserDefaults standardUserDefaults] setObject:dbVersion forKey:kDBVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)p_dbVersion {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDBVersionKey];
}

/// 数据库版本控制主要方法
- (void)p_versionControlWithNewDBVersion:(NSString*)newDbVersion {
    if (nil == _dbFilePath) {
        return;
    }
    
    // 获取新旧版本
    NSString * version_old = BYSafeEmptyString([self p_dbVersion]);
    NSString * version_new = [NSString stringWithFormat:@"%@", newDbVersion];
    NSLog(@"dbVersionControl before: %@ after: %@",version_old,version_new);
    
    // 数据库版本升级
    if (version_old != nil && ![version_new isEqualToString:version_old]) {
        
        // 获取数据库中旧的表
        NSArray* existsTables = [self p_sqliteExistsTables];
        NSMutableArray* tmpExistsTables = [NSMutableArray array];
        
        // 修改表名,添加后缀“_bak”，把旧的表当做备份表
        for (NSString* tablename in existsTables) {
            [tmpExistsTables addObject:[NSString stringWithFormat:@"%@_bak", tablename]];
            [self.databaseQueue inDatabase:^(FMDatabase *db) {
                NSString* sql = [NSString stringWithFormat:@"ALTER TABLE %@ RENAME TO %@_bak", tablename, tablename];
                [db executeUpdate:sql];
            }];
        }
        existsTables = tmpExistsTables;
        
        // 创建新的表
        [self initTables];
        
        // 获取新创建的表
        NSArray* newAddedTables = [self p_sqliteNewAddedTables];
        
        // 遍历旧的表和新表，对比取出需要迁移的表的字段
        NSDictionary* migrationInfos = [self p_generateMigrationInfosWithOldTables:existsTables newTables:newAddedTables];
        
        // 数据迁移处理
        [migrationInfos enumerateKeysAndObjectsUsingBlock:^(NSString* newTableName, NSArray* publicColumns, BOOL * _Nonnull stop) {
            NSMutableString* colunmsString = [NSMutableString new];
            for (int i = 0; i<publicColumns.count; i++) {
                [colunmsString appendString:publicColumns[i]];
                if (i != publicColumns.count-1) {
                    [colunmsString appendString:@", "];
                }
            }
            NSMutableString* sql = [NSMutableString new];
            [sql appendString:@"INSERT INTO "];
            [sql appendString:newTableName];
            [sql appendString:@"("];
            [sql appendString:colunmsString];
            [sql appendString:@")"];
            [sql appendString:@" SELECT "];
            [sql appendString:colunmsString];
            [sql appendString:@" FROM "];
            [sql appendFormat:@"%@_bak", newTableName];
            
            [self.databaseQueue inDatabase:^(FMDatabase *db) {
                [db executeUpdate:sql];
            }];
        }];
        
        // 删除备份表
        [self.databaseQueue inDatabase:^(FMDatabase *db) {
            [db beginTransaction];
            for (NSString* oldTableName in existsTables) {
                NSString* sql = [NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", oldTableName];
                [db executeUpdate:sql];
            }
            [db commit];
        }];
        
        [self p_setDbVersion:version_new];
        
    } else {
        [self p_setDbVersion:version_new];
    }
}

// MARK: - 数据库操作
/// 遍历旧的表和新表，对比取出需要迁移的表的字段
- (NSDictionary*)p_generateMigrationInfosWithOldTables:(NSArray*)oldTables newTables:(NSArray*)newTables {
    NSMutableDictionary<NSString*, NSArray* >* migrationInfos = [NSMutableDictionary dictionary];
    for (NSString* newTableName in newTables) {
        NSString* oldTableName = [NSString stringWithFormat:@"%@_bak", newTableName];
        if ([oldTables containsObject:oldTableName]) {
            // 获取表数据库字段信息
            NSArray* oldTableColumns = [self p_sqliteTableColumnsWithTableName:oldTableName];
            NSArray* newTableColumns = [self p_sqliteTableColumnsWithTableName:newTableName];
            NSArray* publicColumns = [self p_publicColumnsWithOldTableColumns:oldTableColumns newTableColumns:newTableColumns];
            
            if (publicColumns.count > 0) {
                [migrationInfos setObject:publicColumns forKey:newTableName];
            }
        }
    }
    return migrationInfos;
}

/// 提取新表和旧表的共同表字段，表字段相同列的才需要进行数据迁移处理
- (NSArray*)p_publicColumnsWithOldTableColumns:(NSArray*)oldTableColumns newTableColumns:(NSArray*)newTableColumns {
    NSMutableArray* publicColumns = [NSMutableArray array];
    for (NSString* oldTableColumn in oldTableColumns) {
        if ([newTableColumns containsObject:oldTableColumn]) {
            [publicColumns addObject:oldTableColumn];
        }
    }
    return publicColumns;
}

/// 获取数据库表的所有的表字段名
- (NSArray*)p_sqliteTableColumnsWithTableName:(NSString*)tableName {
    __block NSMutableArray<NSString*>* tableColumes = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = [NSString stringWithFormat:@"PRAGMA table_info('%@')", tableName];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString* columnName = [rs stringForColumn:@"name"];
            [tableColumes addObject:columnName];
        }
    }];
    return tableColumes;
}

/// 获取数据库中旧的表
- (NSArray*)p_sqliteExistsTables {
    __block NSMutableArray<NSString*>* existsTables = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = @"SELECT * from sqlite_master WHERE type='table'";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString* tablename = [rs stringForColumn:@"name"];
            [existsTables addObject:tablename];
        }
    }];
    return existsTables;
}

/// 获取新创建的表
- (NSArray*)p_sqliteNewAddedTables {
    __block NSMutableArray<NSString*>* newAddedTables = [NSMutableArray array];
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        NSString* sql = @"SELECT * from sqlite_master WHERE type='table' AND name NOT LIKE '%_bak'";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString* tablename = [rs stringForColumn:@"name"];
            [newAddedTables addObject:tablename];
        }
    }];
    return newAddedTables;
}

// MARK: - ---- Getter
/// readonly
- (FMDatabaseQueue *)databaseQueue {
    if (nil == _dbFilePath) {
        return nil;
    }
    pthread_mutex_lock(&_dbLock);
    if (_databaseQueue == nil) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:_dbFilePath flags:SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE];
    }
    pthread_mutex_unlock(&_dbLock);
    return _databaseQueue;
}

@end
