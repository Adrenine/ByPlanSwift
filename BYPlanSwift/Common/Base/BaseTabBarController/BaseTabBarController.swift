//
//  BaseTabBarController.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/19.
//

import UIKit

struct BaseTabBarControllerInfo {
    var controllerName: String
    var title: String
    var tabBarItemViewName: String?
    var imageName: String
    var selectImageName: String?
    
    init(title: String, controllerName: String, tabBarItemViewName: String? = nil, imageName: String, selectImageName:String? = nil) {
        self.controllerName = controllerName
        self.title = title
        self.tabBarItemViewName = tabBarItemViewName
        self.imageName = imageName
        self.selectImageName = selectImageName
    }
}

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var infoArray : [BaseTabBarControllerInfo] = []
    
    init(withArray infoArray: [BaseTabBarControllerInfo]) {
        self.infoArray = infoArray
        super.init(nibName: nil, bundle: nil)
        p_setupViewControllers()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - ---- Private method
    private func p_setupViewControllers() {
        var viewControllers : [UIViewController] = []
        for info in self.infoArray {

            guard let vcClass = ProjectInfo.getClassFromString(info.controllerName) as? UIViewController.Type else {
                continue
            }
            
            let vc = vcClass.init()
            var selectImage : UIImage?
            if let selectImageName = info.selectImageName {
                selectImage = UIImage.init(named: selectImageName)
                selectImage!.withRenderingMode(.alwaysOriginal)
            }
            
            let tabBarItem = UITabBarItem.init(title: info.title, image: UIImage.init(named: info.imageName)!.withRenderingMode(.alwaysOriginal), selectedImage: selectImage)
            vc.tabBarItem = tabBarItem
            viewControllers.append(p_getNavigationControllerWithController(vc: vc))
        }
        self.viewControllers = viewControllers
        self.delegate = self
    }
    
    private func p_getNavigationControllerWithController(vc : UIViewController) -> BaseNavigationController{
        let nav = BaseNavigationController.init(rootViewController: vc)
        return nav
    }
    
    // MARK: - ---- Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
