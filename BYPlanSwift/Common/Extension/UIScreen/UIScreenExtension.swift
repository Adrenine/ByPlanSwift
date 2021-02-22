//
//  UIScreenExtension.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/29.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

extension UIScreen {
    static func width() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static func height() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
}
