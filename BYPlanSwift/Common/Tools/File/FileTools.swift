//
//  FileTools.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/8/12.
//  Copyright © 2020 hd. All rights reserved.
//

import Foundation

struct FileTools {
    static func existPlistFile(fileName: String) -> Bool {
        guard let _ = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            return false
        }
        return true
    }
    
    static func getPlistFileData(fileName: String) -> Dictionary<String, Any> {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            return [:]
        }
        let dataDic = NSDictionary.init(contentsOfFile: path)
        return dataDic as! Dictionary<String, Any>
    }
    
    static func fileExists(inPath path:String) -> Bool {
        
        let fileManager = FileManager.default
        
        let result = fileManager.fileExists(atPath: path)
        
        if result {
            return true
        } else {
            return false
        }
    }
    
    static func creatFolder(inPath path:String) {
        
        let fileManager = FileManager.default
        
        do {
            // 创建文件夹   1，路径 2 是否补全中间的路劲 3 属性
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("creat false")
        }
    }
    
    static func creatFile(inPath path:String, fileName name: String) -> Bool {
        
        let fileManager = FileManager.default
        let p = path.appendingPathComponent(name)
        return fileManager.createFile(atPath: p, contents: nil, attributes: nil)
        
    }
    
    static func removeFilePath(path:String){
        
        let fileManager = FileManager.default
        
        do{
            try fileManager.removeItem(atPath: path)
        } catch{
            print("creat false")
        }
    }
}
