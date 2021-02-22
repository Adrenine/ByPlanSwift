//
//  String+Extension.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/18.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

extension String {
    func isCorrectIp() -> Bool {
        let pattern = "((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})(\\.((2(5[0-5]|[0-4]\\d))|[0-1]?\\d{1,2})){3}"
        do {
            let regular = try NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
            let result = regular.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange.init(location: 0, length: self.count))
            if result.count > 0 {
                return true
            }
        } catch {
            
        }
        
        return false
    }
}

extension String {

    // MARK: - ---- StringAttribute
    
    /// Get the string's height with the fixed width.
    /// - Parameters:
    ///   - attribute: String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
    ///   - fixedWidth: Fixed width.
    /// - Returns: String's height.
    func heightWithString(attribute : [NSAttributedString.Key : Any]?, fixedWidth width:  CGFloat) -> CGFloat {
        
        var height : CGFloat = 0
        if self.count > 0 {
            let rect : CGRect = self.boundingRect(with: CGSize.init(width: Double(width), height: Double(MAXFLOAT)), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes:attribute, context: nil)
            height = rect.size.height
        }
        
        return height
    }
    
    /// Get the string's width.
    /// - Parameter attribute: String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
    /// - Returns: String's width.
    func widthWithString(attribute : [NSAttributedString.Key : Any]?) -> CGFloat {
        var width : CGFloat = 0
        if self.count > 0 {
            let rect : CGRect = self.boundingRect(with: CGSize.init(width: Double(MAXFLOAT), height: 0), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes:attribute, context: nil)
            width = rect.size.width
        }
        return width
    }

    /// Get a line of text height.
    /// - Parameter attribute: String's attribute, eg. attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
    /// - Returns: String's width.
    func oneLineOfTextHeightWithString(attribute: [NSAttributedString.Key : Any]?) -> CGFloat {
        
        let rect : CGRect = "One".boundingRect(with: CGSize.init(width: 200, height: Double(MAXFLOAT)), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes:attribute, context: nil)
        return rect.size.height
    }
    
    // MARK: - ---- Font
    /// Get the string's height with the fixed width.
    /// - Parameters:
    ///   - font: String's font.
    ///   - fixedWidth: Fixed width.
    /// - Returns: String's height.
    func heightWithString(font: UIFont, fixedWidth width: CGFloat) -> CGFloat {
        var height : CGFloat = 0
        if self.count > 0 {
            let rect : CGRect = self.boundingRect(with: CGSize.init(width: Double(width), height: Double(MAXFLOAT)), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes:[NSAttributedString.Key.font : font], context: nil)
            height = rect.size.height
        }
        return height
    }
    
    /// Get the string's width.
    /// - Parameter font: String's font.
    /// - Returns: String's width.
    func widthWithString(font: UIFont) -> CGFloat {
        
        var width : CGFloat  = 0
        
        if self.count > 0 {
            let rect : CGRect = self.boundingRect(with: CGSize.init(width: Double(MAXFLOAT), height: 0.0), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
            width = rect.size.width;
        }
        
        return width;
    }

    /// Get a line of text height.
    /// - Parameter font: String's font.
    /// - Returns: String's width.
    func oneLineOfTextHeightWithString(font: UIFont) -> CGFloat {
        
        let rect = "One".boundingRect(with: CGSize.init(width: 200, height: Double(MAXFLOAT)), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.height
        
    }
}


