//
//  BYBaseDatabaseManager.h
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/11.
//

#import <UIKit/UIKit.h>
#import <fmdb/FMDB.h>

@interface BYBaseDatabaseManager : NSObject

///数据库操作Queue
@property (nonatomic, strong, readonly) FMDatabaseQueue *databaseQueue;

/// 设置数据库文件路径和版本号
/// @param dbFilePath <#DBFilePath description#>
/// @param newDbVersion <#newDBVersion description#>
- (void)setDbFilePath:(NSString *)dbFilePath newDbVersion:(NSString*)newDbVersion;

/// 初始化数据表，子类需要重写该方法
- (void)initTables;

@end
