//
//  KMLog.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/6/4.
//  Copyright © 2020 hd. All rights reserved.
//

import Foundation

class BYLog {

    static func printLog<T>(_ message:T, file:String = #file, funcName:String = #function, lineNum:Int = #line) {

//        let fileName = (file as NSString).lastPathComponent;
#if DEBUG
//        print("[\(fileName):line:\(lineNum)]:\n \(message)")
        print("\(message)")
#endif
    }
}


