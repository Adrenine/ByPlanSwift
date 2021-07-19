//
//  AppDelegate.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        pageSetting()
        appSettting()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
}

extension AppDelegate {
    func appSettting () {
        p_appearanceSetting()
    }
    
    func pageSetting() {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = TabBarController(viewControllers: TabBarController.viewControllersForTabBar(), tabBarItemsAttributes: TabBarController.tabBarItemsAttributesForTabBar())
        let color = UIColor.rgbColor(29.0/255.0, 173.0/255.0, 234.0/255.0)
        self.window?.tintColor = color
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - ---- Private methos
    private func p_appearanceSetting() {
        let image = R.image.icon_back()
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16)]
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = BYStatusBarColor

        UITabBar.appearance().tintColor = BYTabBarColor

        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.clear], for: .normal)
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        
        // 滚动高度跳动，上下拉刷新问题
        UITableView.appearance().estimatedRowHeight = 0
        UITableView.appearance().estimatedSectionHeaderHeight = 0
        UITableView.appearance().estimatedSectionFooterHeight = 0
        
    }
}


