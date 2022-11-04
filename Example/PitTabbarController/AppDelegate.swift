//
//  AppDelegate.swift
//  PitTabbarController
//
//  Created by imwalsh on 11/02/2022.
//  Copyright (c) 2022 imwalsh. All rights reserved.
//

import UIKit
import PitTabbarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let tabBarController = PitTabbarController()
        
		let v1 = OneController()
        let v2 = TwoController()
        let v3 = ThreeController()
        let v4 = FourController()
		
		v1.tabBarItem = UITabBarItem(title: "ONE", image: UIImage(named: "Home"), tag: 0)
        v2.tabBarItem = UITabBarItem(title: "TWO", image: UIImage(named: "Location"), tag: 1)
        v3.tabBarItem = UITabBarItem(title: "THREE", image: UIImage(named: "Comment"), tag: 2)
        v4.tabBarItem = UITabBarItem(title: "FOUR", image: UIImage(named: "Cloud"), tag: 3)
		
        tabBarController.viewControllers = [v1, v2, v3, v4]
        
        window?.rootViewController = tabBarController
                        
		window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

