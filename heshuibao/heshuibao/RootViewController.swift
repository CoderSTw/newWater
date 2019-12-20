//
//  RootViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = setupChildVC(vc: TodayViewController(), title: "今日", imgName: "today")
        
        let _ = setupChildVC(vc: RecordViewController(), title: "记录", imgName: "record")
        
        let _ = setupChildVC(vc: ReminderViewController(), title: "提醒", imgName: "reminder")
        
        let _ = setupChildVC(vc: SetViewController(), title: "设置", imgName: "set")
        
        
        tabBar.tintColor = UIColor(r: 37, g: 124, b: 219)
        tabBar.unselectedItemTintColor = UIColor(r: 194, g: 203, b: 223)
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
    }

}

extension RootViewController {
    func setupChildVC(vc: UIViewController, title: String, imgName: String) {
        
        let nav = UINavigationController(rootViewController: vc)
        if #available(iOS 11.0, *) {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationItem.largeTitleDisplayMode = .always
        } else {
        }
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imgName)
        vc.tabBarItem.selectedImage = UIImage(named: imgName + "Sel")
        addChild(nav)
    }
}
