//
//  UIColorExtension.swift
//  KommanderTouPing
//
//  Created by Kystar's Mac Book Pro on 2020/3/26.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgbColor(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    static func rgbColor(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    static func hexColor(_ hexadecimal : String, alpha: CGFloat) -> UIColor{
        if alpha > 1 {
            return UIColor.black
        }
        if alpha < 0 {
            return UIColor.clear
        }
        
        var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
         }
        if(cstr.hasPrefix("0X") || cstr.hasPrefix("0x")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
          cstr = cstr.substring(from: 1) as NSString
        }
         if(cstr.length != 6){
          return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha);
    }
    
    static func hexColor(_ hexadecimal : String) -> UIColor{
        return UIColor.hexColor(hexadecimal, alpha: 1.0)
    }
}

