//
//  AppDelegate.swift
//  DemoLoopyPlayer
//
//  Created by 김동준 on 2021/07/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        var rootVC = WalletLoginViewController()
        var reactor = WalletLoginReactor()
        rootVC.reactor = reactor
        window?.rootViewController = rootVC
        
        return true
    }

}

