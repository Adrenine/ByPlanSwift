//
//  BYButtonPopMenu.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/2/26.
//

import Foundation
import UIKit
import QuartzCore

enum BYButtonPopMenuBackgroundEffectType : Int {
    case none
    case dark
    case blurEffectExtraLight
    case blurEffectLight
    case blurEffectDark
}

@objc protocol BYButtonPopMenuDelegate: NSObjectProtocol {
    @objc optional func byButtonPopMenuSelected(_ selectedMenuName: String?, at index: Int)
}

class BYButtonPopMenu: NSObject {
    weak var delegate: BYButtonPopMenuDelegate?
    // Disable background view user interaction, default is true
    var disableBackgroundUserInteraction = true
    // Default is BlurEffectDark
    var backgroundEffectType: BYButtonPopMenuBackgroundEffectType = .none
    // Maximium number of column,default is 3
    var maxColumn = 3
    // Single menu button side length,default is 65
    var menuButtonSideLength = 65
    // Number of menu items to show
    var numberOfMenuItem : Int
    // Radius for circular menu, default is 120
    var menuRadius: CGFloat = 120
    // Menu button reference
    var popMenuButton: UIButton?
//    // Menu super view reference
//    var menuSuperView: UIView?
    // Menu items name array,it can be empty
    var menuItemsNameArray: [String]?
    // Menu items background color,it can be empty, default color is white
    var menuBackgroundColorsArray: [UIColor]?
    // Menu item icons array it can be empty
    var menuImagesNameArray: [String]?
    // Menu title color, default is white
    var menuTitleColor: UIColor = .white
    // Menu title font, default is system regular 12
    var menuTitleFont: UIFont = .systemFont(ofSize: 12)
    
    override init() {
        self.numberOfMenuItem = 3
    }
    
    init(numberOfMenuItem: Int) {
        self.numberOfMenuItem = numberOfMenuItem
    }
    
    func showMenu() {
    }

    func hideMenu() {
    }
    
    private let animationDuration = 0.4
    private let menuBackgroundViewTag = 2333
    private var menuButtonArray : [UIButton] = []
    private var menuNameLabelArray : [UILabel] = []
    private lazy var menuButtonContentView : UIView = UIView.init(frame: UIScreen.main.bounds)
    private var popMenuButtonCenterPoint : CGPoint?
    
    private func viewTag(offset: Int) -> Int {
        return offset + 3000
    }
    
    private func createMenuButtons() {
        menuButtonArray.removeAll()
        menuNameLabelArray.removeAll()
        for i in 0..<numberOfMenuItem {
            let button = UIButton.init(type: .custom)
            button.backgroundColor = .white
            button.tag = viewTag(offset: i)
            var calcFrame = button.frame
            calcFrame.size = CGSize.init(width: menuButtonSideLength, height: menuButtonSideLength)
            button.frame = calcFrame
            if let center = popMenuButtonCenterPoint {
                button.center = center
            }
            button.layer.cornerRadius = button.frame.size.height * 0.5
            button.layer.masksToBounds = true
            button.layer.opacity = 0
            button.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
            menuButtonContentView.addSubview(button)
            menuButtonArray.append(button)
            
            if let array = menuItemsNameArray, array.count > i {
                let label = UILabel()
                label.backgroundColor = .clear
                label.numberOfLines = 1
                calcFrame = label.frame
                calcFrame.size = CGSize.init(width: button.frame.size.width, height: 20)
                label.frame = calcFrame
                label.center = button.center
                label.layer.opacity = 0
                label.textAlignment = .center
                label.font = menuTitleFont
                label.textColor = menuTitleColor
                label.text = array[i]
                label.sizeToFit()
                menuButtonContentView.insertSubview(label, belowSubview: button)
                menuNameLabelArray.append(label)
            }
        
            if let array = menuBackgroundColorsArray, array.count > i {
                button.backgroundColor = array[i]
            }
            
            if let array = menuImagesNameArray, array.count > i {
                button.setImage(UIImage.init(named: array[i]), for: .normal)
            }
        }
        
    }
    
    @objc private func clickMenuButton(_ sender: UIButton) {
        
    }
    
    private func menuContentViewBackgroundSetting() {
        menuButtonContentView.isUserInteractionEnabled = !disableBackgroundUserInteraction
        backgroundEffectSetting()
    }

    private func backgroundEffectSetting() {
        switch backgroundEffectType {
        case .dark:
            menuButtonContentView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        case .blurEffectDark:
            setBlurredView(effectStyle: .dark)
        case .blurEffectLight:
            setBlurredView(effectStyle: .light)
        case .blurEffectExtraLight:
            setBlurredView(effectStyle: .extraLight)
        default:
            menuButtonContentView.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    private func setBlurredView(effectStyle: UIBlurEffect.Style) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            let effect = UIBlurEffect.init(style: effectStyle)
            let effectView = UIVisualEffectView.init(effect: effect)
            effectView.frame = menuButtonContentView.bounds
            effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            menuButtonContentView.addSubview(effectView)
        } else {
            menuButtonContentView.backgroundColor = .clear
        }
    }
}
