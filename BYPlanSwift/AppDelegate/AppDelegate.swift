//
//  AppDelegate.swift
//  BYPlanSwift
//
//  Created by Kystar's Mac Book Pro on 2021/1/11.
//

import UIKit
import ESTabBarController_swift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow? = UIWindow.init(frame: UIScreen.main.bounds)
    var tabBarVC: ESTabBarController!
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let color = UIColor.rgbColor(29.0/255.0, 173.0/255.0, 234.0/255.0)
        self.window?.tintColor = color
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
//        self.tabBarVC = baseTabBarController()
//        self.window?.rootViewController = self.tabBarVC
        self.window?.rootViewController = TabBarController(viewControllers: TabBarController.viewControllersForTabBar(), tabBarItemsAttributes: TabBarController.tabBarItemsAttributesForTabBar())
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

//extension AppDelegate: UITabBarControllerDelegate {
//    func baseTabBarController() -> ESTabBarController {
//        let tabBarController = ESTabBarController()
//        tabBarController.delegate = self
//        tabBarController.tabBar.shadowImage = R.image.tab_transparent()
//        tabBarController.tabBar.backgroundImage = R.image.tab_background_dark()
//        tabBarController.shouldHijackHandler = {
//            tabbarController, viewController, index in
//            if index == 2 {
//                return true
//            }
//            return false
//        }
//        tabBarController.didHijackHandler = {
//            [weak tabBarController] tabbarController, viewController, index in
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
//                alertController.addAction(takePhotoAction)
//                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
//                alertController.addAction(selectFromAlbumAction)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                tabBarController?.present(alertController, animated: true, completion: nil)
//            }
//        }
//
//        let clockVCTitle = R.string.localizable.clock_page()
//        let recordVCTitle = R.string.localizable.record_page()
//        let reportVCTitle = R.string.localizable.report_page()
//        let mineVCTitle = R.string.localizable.mine_page()
//
//        let clockVC = BYClockViewController()
//        let recordVC = BYRecordViewController()
//        let addVC = BYAddViewController()
//        let reportVC = BYFavorViewController()
//        let mineVC = BYMineViewController()
//
//        clockVC.title = clockVCTitle
//        recordVC.title = recordVCTitle
//        reportVC.title = reportVCTitle
//        mineVC.title = mineVCTitle
//
//        clockVC.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: clockVCTitle, image: R.image.tab_clock(), selectedImage: R.image.tab_clock_sel())
//        recordVC.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: recordVCTitle, image: R.image.tab_record(), selectedImage: R.image.tab_record_sel())
//        addVC.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: R.image.tab_add(), selectedImage: R.image.tab_add_sel())
//        reportVC.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: reportVCTitle, image: R.image.tab_report(), selectedImage: R.image.tab_report_sel())
//        mineVC.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: mineVCTitle, image: R.image.tab_me(), selectedImage: R.image.tab_me_sel())
//
//        let nav1 = BaseNavigationController.init(rootViewController: clockVC)
//        let nav2 = BaseNavigationController.init(rootViewController: recordVC)
//        let nav3 = BaseNavigationController.init(rootViewController: addVC)
//        let nav4 = BaseNavigationController.init(rootViewController: reportVC)
//        let nav5 = BaseNavigationController.init(rootViewController: mineVC)
//
//        tabBarController.viewControllers = [nav1, nav2, nav3, nav4, nav5]
//
//        return tabBarController
//    }
//}


