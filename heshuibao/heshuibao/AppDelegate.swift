//
//  AppDelegate.swift
//  heshuibao
//
//  Created by ST on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = RootViewController()
//        window?.rootViewController = BeginViewController()
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

