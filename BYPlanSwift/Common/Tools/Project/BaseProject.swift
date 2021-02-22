//
//  BaseProject.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/19.
//

import Foundation

class ProjectInfo {
    public class func getClassFromString(_ classString: String) -> AnyClass? {
        guard let bundleName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return nil
        }
        var anyClass: AnyClass? = NSClassFromString(bundleName + "." + classString)
        if (anyClass == nil) {
            anyClass = NSClassFromString(classString)
        }
        return anyClass
    }
}

