//
//  BYTabBarController.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/13.
//

class BYTabBarController: BaseTabBarController {
    
    init() {
        let infoArray : [BaseTabBarControllerInfo] = []
        super.init(withArray: infoArray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func p_getNavigationControllerWithController(vc : UIViewController) -> BaseNavigationController{
        let nav = BaseNavigationController.init(rootViewController: vc)
        return nav
    }
}


