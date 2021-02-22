//
//  BaseNavigationController.swift
//  KommanderLite
//
//  Created by Kystar's Mac Book Pro on 2020/5/18.
//  Copyright © 2020 kystar. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationBar.barTintColor = .rgbColor(38, 38, 38)
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {

            let back = UIButton.init(type: .custom)
//            back.setTitle("back".localized(), for: .normal)
//            back.setTitleColor(.gray, for: .normal)
//            back.setTitleColor(.blue, for: .highlighted)
            back.setImage(R.image.icon_back(), for: .normal)
            back.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
            back.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
            back.contentHorizontalAlignment = .left
            back.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: -10, bottom: 0, right: 0)
            back.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
            viewController.navigationItem.backBarButtonItem = UIBarButtonItem.init(customView: back)
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc private func backAction(sender: UIButton) {
        if children.count > 1 {
            popViewController(animated: true)
        }
    }
    
}
