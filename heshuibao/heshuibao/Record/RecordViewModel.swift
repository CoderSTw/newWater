//
//  RecordViewModel.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/27.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import CoreData

class RecordViewModel: NSObject {
    
    
    static func getWeekItems() -> [RecordSnpItem] {
        // 判断今天星期几
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let compoments = calendar.component(Calendar.Component.weekday, from: Date())
        var weekNum = compoments-1
        if weekNum==0 { weekNum = 7 }
        
        //
        var items = Array<RecordSnpItem>()
        
        //
        for i in 1..<weekNum {
            // 之前
            let mydate = Date.init(timeIntervalSinceNow: -TimeInterval(60 * 60 * 24 * i))
            let returnItem = CoreDataManager.shared.getItemWithDate(date: mydate)
            
//            print(returnItem.progress)
//            print("--------")
            
            items.insert(returnItem, at: 0)
            
        }
        
        // 今天
        let snpItem = RecordSnpItem()
        snpItem.date = Date()
        snpItem.mlVlalue = TodayViewModel.getTodayCount()
        snpItem.progress = TodayViewModel.getProgress()
        items.append(snpItem)
        
        // 之后
        for i in weekNum..<7 {
            
            let day = (i-weekNum+1)
            
            let snpItem = RecordSnpItem()
            snpItem.date = Date.init(timeIntervalSinceNow: TimeInterval(60 * 60 * 24 * day))
            snpItem.mlVlalue = 0
            snpItem.progress = -1
            items.append(snpItem)
        }
        
        //打印
        for item in items {
            let fmt = DateFormatter()
            fmt.dateFormat = "MM/dd"
            let str = fmt.string(from: item.date!)
            print("\(item.mlVlalue)" + "-----" +  "\(str)")
        }
        
        return items
    }
}
