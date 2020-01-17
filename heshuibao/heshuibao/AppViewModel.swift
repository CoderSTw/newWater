//
//  AppViewModel.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/27.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class AppViewModel: NSObject {
    
    static func checkDateAddRecord() {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd"
        
        let noneDate = Date.init(timeIntervalSince1970: -100)
        let saveDate: Date = UserDefaults.standard.object(forKey: "SAVE_DATE")==nil ? noneDate : UserDefaults.standard.object(forKey: "SAVE_DATE") as! Date
        if (saveDate==noneDate) {
            UserDefaults.standard.set(Date(), forKey: "SAVE_DATE")
            return
        }
        
        let savedayStr = fmt.string(from: saveDate)
        let todayStr = fmt.string(from: Date())
        
        
        if todayStr==savedayStr {
        }else {
            // 不一样 保存记录
            CoreDataManager.shared.saveReordItemWith(date: saveDate, mlValue: Int64(TodayViewModel.getTodayCount()), progress: Int64(TodayViewModel.getProgress()))
            
            // 清空数据啊大哥
            TodayViewModel.setTodayCount(value: 0)
            TodayAddItem.RemoveAllItem()
            
            // 保存日期
            UserDefaults.standard.set(Date(), forKey: "SAVE_DATE")
        }
    }
}
