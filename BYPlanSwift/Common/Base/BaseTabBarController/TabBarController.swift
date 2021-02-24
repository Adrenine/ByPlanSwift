//
//  TabBarController.swift
//  BYPlanSwift
//
//  Created by Sun on 2021/2/24.
//

import CYLTabBarController

/// 基础 tabbar 控制器
class TabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabBarPlusButton.register()
        // Do any additional setup after loading the view.
    }
    
}


extension TabBarController {
    
    /// 生成 tabBar 持有的导航控制器
    /// - Returns: tabBar 持有的导航控制器
    static func viewControllersForTabBar() -> [UINavigationController] {
        
        // tabItem 控制器
        let clockVC = BYClockViewController()
        let recordVC = BYRecordViewController()
        let reportVC = BYFavorViewController()
        let mineVC = BYMineViewController()
        
        // tabItem 标题
        clockVC.title = R.string.localizable.clock_page()
        recordVC.title = R.string.localizable.record_page()
        reportVC.title = R.string.localizable.report_page()
        mineVC.title = R.string.localizable.mine_page()
        
        let nav1 = BaseNavigationController.init(rootViewController: clockVC)
        let nav2 = BaseNavigationController.init(rootViewController: recordVC)
        
        let nav4 = BaseNavigationController.init(rootViewController: reportVC)
        let nav5 = BaseNavigationController.init(rootViewController: mineVC)
        
        return [nav1, nav2, nav4, nav5]
    }
    
    /// 生成 tabBar 的 item 属性
    /// - Returns: tabBar 的 item 属性
    static func tabBarItemsAttributesForTabBar() -> [[String: Any]] {
        
        let firstItemAttributes = [CYLTabBarItemTitle: R.string.localizable.clock_page(),
                                   CYLTabBarItemImage: R.image.tab_clock() as Any,
                                   CYLTabBarItemSelectedImage: R.image.tab_clock_sel() as Any,
                                   CYLTabBarItemTitlePositionAdjustment: UIOffset.zero] as [String : Any]
        
        let secondItemAttributes = [CYLTabBarItemTitle: R.string.localizable.record_page(),
                                    CYLTabBarItemImage: R.image.tab_record() as Any,
                                    CYLTabBarItemSelectedImage: R.image.tab_record_sel() as Any,
                                    CYLTabBarItemTitlePositionAdjustment: UIOffset.zero] as [String : Any]
        
        let fourthItemAttributes = [CYLTabBarItemTitle: R.string.localizable.report_page(),
                                    CYLTabBarItemImage: R.image.tab_report() as Any,
                                    CYLTabBarItemSelectedImage: R.image.tab_report_sel() as Any,
                                    CYLTabBarItemTitlePositionAdjustment: UIOffset.zero] as [String : Any]
        
        let fifthItemAttributes = [CYLTabBarItemTitle: R.string.localizable.mine_page(),
                                   CYLTabBarItemImage: R.image.tab_me() as Any,
                                   CYLTabBarItemSelectedImage: R.image.tab_me_sel() as Any,
                                   CYLTabBarItemTitlePositionAdjustment: UIOffset.zero] as [String : Any]
        
        return [firstItemAttributes, secondItemAttributes, fourthItemAttributes, fifthItemAttributes]
    }
}
