//
//  RootViewController.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
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
        tabBar.barTintColor = COLOR_BGCOLOR
        tabBar.backgroundColor = COLOR_BGCOLOR
        
        NotificationCenter.default.addObserver(self, selector: #selector(noti), name: NSNotification.Name.init(rawValue: "dark_mode"), object: nil)
        
        if UserDefaults.standard.bool(forKey: DAEK_MODE_KEY)==true {
            if #available(iOS 13.0, *) {
                self.overrideUserInterfaceStyle = .dark
            }
        }else {
            if #available(iOS 13.0, *) {
                self.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        
        super.viewDidAppear(animated)
        
        // 判断是否为第一次
        if UserDefaults.standard.bool(forKey: FIRST_TIME_KEY)==true { return }
        
        // 添加提示语
        UserDefaults.standard.set(["喝口水休息一下吧", "到时间喝水了", "快喝口水吧", "多喝热水...", "美好的一天从喝水开始"], forKey: NOTE_ARR_KEY)
        UserDefaults.standard.set([2,4,6,8,10], forKey: TIME_SEL_ROW_KEY)
        UserDefaults.standard.set("未设置昵称", forKey: NEAL_NAME_KEY)
        
        // 是的话就要跳转到begin
        let beginVC = BeginViewController()
        beginVC.modalPresentationStyle = .fullScreen
        present(beginVC, animated: true, completion: nil)
        UserDefaults.standard.set(true, forKey: FIRST_TIME_KEY)
        
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
        nav.navigationBar.isHidden = true
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imgName)
        vc.tabBarItem.selectedImage = UIImage(named: imgName + "Sel")
        addChild(nav)
    }
    
    @objc func noti(noti: Notification) {
        let info = noti.userInfo
        let aaa = info?["info"] as! Bool
        if aaa==true {
            if #available(iOS 13.0, *) {
                self.overrideUserInterfaceStyle = .dark
            } else {
                // Fallback on earlier versions
            }
        }else {
            if #available(iOS 13.0, *) {
                self.overrideUserInterfaceStyle = .light
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
