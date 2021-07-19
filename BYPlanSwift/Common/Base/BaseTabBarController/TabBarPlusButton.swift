//
//  TabBarPlusButton.swift
//  BYPlanSwift
//
//  Created by Sun on 2021/2/24.
//

import CYLTabBarController

class TabBarPlusButton: CYLPlusButton {
    static let menuItemsNameArray = ["Home","Like","Search","User","Buy"]
    static let bgColorArray = [UIColor.hexColor("#21B4E3"),
                        UIColor.hexColor("#8B74F0"),
                        UIColor.hexColor("#F17679"),
                        UIColor.hexColor("#B8CCCF"),
                        UIColor.hexColor("#A93BBC")]
    static let menuImagesNameArray = ["home","favourite","search","user","buy"]
    var buttonSelected = false
    lazy var igcMenu: IGCMenu = {
        let menu = IGCMenu()
        menu.disableBackground = true
        menu.numberOfMenuItem = 5
        menu.menuTitleFont = .systemFont(ofSize: 12)
        menu.menuTitleColor = .lightGray
        menu.backgroundType = .None
        menu.menuItemsNameArray = TabBarPlusButton.menuItemsNameArray
        menu.menuBackgroundColorsArray = TabBarPlusButton.bgColorArray
        menu.menuImagesNameArray = TabBarPlusButton.menuImagesNameArray
        menu.delegate = self
        menu.menuRadius = 140
        return menu
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.textAlignment = .center
        adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TabBarPlusButton: IGCMenuDelegate {
    func igcMenuSelected(_ selectedMenuName: String!, at index: Int) {
        BYLog.printLog(index)
    }
}

extension TabBarPlusButton: CYLPlusButtonSubclassing {
    
    static func plusButton() -> Any {
        let button = TabBarPlusButton()
        button.setImage(R.image.tab_add(), for: .normal)
        button.setImage(R.image.tab_add_sel(), for: [.highlighted, .selected])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9.5)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
//        button.addTarget(button, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }
    
//    @objc func clickButton(_ sender: TabBarPlusButton) {
//
//        let vc = cyl_tabBarController.selectedViewController
//        BYLog.printLog(vc?.title)
//
//    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 2
    }
    
    static func multiplier(ofTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 0.1
    }
    
    override func plusChildViewControllerButtonClicked(_ sender: UIButton & CYLPlusButtonSubclassing) {
        super.plusChildViewControllerButtonClicked(sender)
        
        let vc = cyl_tabBarController.selectedViewController
        BYLog.printLog(vc?.title)
        igcMenu.showMenuButton = sender
        igcMenu.menuSuperView = vc?.view
        buttonSelected = !buttonSelected
        
        if buttonSelected {
            igcMenu.showCircularMenu()
            sender.setImage(R.image.tab_cancel(), for: .normal)
            sender.setImage(R.image.tab_cancel_sel(), for: .highlighted)
        } else {
            igcMenu.hideCircularMenu()
            sender.setImage(R.image.tab_add(), for: .normal)
            sender.setImage(R.image.tab_add_sel(), for: .highlighted)
        }
    }
    
    static func plusChildViewController() -> UIViewController {
        let vc = BYAddViewController()
        vc.title = "add"
        return vc
    }
    
}
