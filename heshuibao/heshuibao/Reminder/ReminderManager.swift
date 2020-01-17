//
//  ReminderManager.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/14.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderManager: NSObject {
    
    // MARK: - 创建单利
    static let instences_reminder: ReminderManager = ReminderManager()
    class func shareManager() -> ReminderManager {
        return instences_reminder
    }
    
    let center = UNUserNotificationCenter.current()
    
    // MARK: - 清空
    func clearAllReminder() {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }
    
    // MARK: - 打印通知
    func printAllReminder() {
        
        print("--------------------------")
        
        center.getPendingNotificationRequests { (requests:[UNNotificationRequest]) in
            
            for request in requests {
                print(request.identifier)
            }
        }
    }
}

extension ReminderManager {
    func addReminder() {
        // 0. 先清空
        clearAllReminder()
        
        // 1. 发送的时间数组
        let postTimeArr = UserDefaults.standard.array(forKey: TIME_SEL_ROW_KEY) as! [Int]
        
        // 2. 发送通知
        // 2. 创建一天内的通知
        for x in postTimeArr {
            // 内容
            let content = UNMutableNotificationContent()
            // 时间
            content.title = x<3 ? "0\(x+7) : 00" : "\(x+7) : 00"
            // 提示语
            let noteSelIndex = UserDefaults.standard.integer(forKey: NOTE_SEL_ROW_KEY)
            let noteArr = UserDefaults.standard.array(forKey: NOTE_ARR_KEY)
            content.body = noteArr![noteSelIndex] as! String
            // 铃声
            let ringIndex = UserDefaults.standard.integer(forKey: RING_SEL_ROW_KEY)
            if ringIndex == 0 {
                content.sound = UNNotificationSound.default
            }else {
                content.sound = UNNotificationSound.init(named: UNNotificationSoundName.init("\(x+9).mp3"))
            }
            content.badge = 1
            
            // 时间
            var dateComponents = DateComponents()
            dateComponents.hour = x+7
            dateComponents.minute = 0
            let calendarTrigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: true)
            
            // 添加请求
            let request = UNNotificationRequest.init(identifier: "reminder\(String(describing: dateComponents.hour)):\(String(describing: dateComponents.minute))", content: content, trigger: calendarTrigger)
            print(request.identifier)
            
            // 添加推送
            center.add(request, withCompletionHandler: nil)
            
            center.getPendingNotificationRequests {
                (requests:[UNNotificationRequest]) in
            }
        }
    }
}

// MARK: - 开启权限
extension ReminderManager {
    func checkReminderPower(NoQuanxianHandle: @escaping ()->(), OpenHandle: @escaping ()->()) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: (UNAuthorizationOptions(rawValue: UNAuthorizationOptions.badge.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.alert.rawValue))) { (grand, error) in
            if grand == true {
                OpenHandle()
            }else {
                // 没有打开权限的回调
                NoQuanxianHandle()
            }
        }
    }
}
