//
//  TabBarPlusButton.swift
//  BYPlanSwift
//
//  Created by Sun on 2021/2/24.
//

import CYLTabBarController

class TabBarPlusButton: CYLPlusButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel?.textAlignment = .center
        adjustsImageWhenHighlighted = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TabBarPlusButton: CYLPlusButtonSubclassing {
    
    static func plusButton() -> Any {
        let button = TabBarPlusButton()
        button.setImage(R.image.tab_add(), for: .normal)
        button.setImage(R.image.tab_add_sel(), for: [.highlighted, .selected])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9.5)
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        button.addTarget(button, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func clickButton(_ sender: TabBarPlusButton) {
        let vc = cyl_tabBarController.selectedViewController
        
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
        alertController.addAction(takePhotoAction)
        let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
        alertController.addAction(selectFromAlbumAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        vc?.present(alertController, animated: true, completion: nil)
    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 2
    }
    
    static func multiplier(ofTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 0.1
    }
    
}
