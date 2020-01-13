//
//  TodayViewModel.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/23.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class TodayViewModel: NSObject {
    
    // SETTER && GETTER
    static func getTodayCount() -> Int {
        return UserDefaults.standard.integer(forKey: "TODAY_COUNT_VALUE")
    }
    
    static func setTodayCount(value: Int) {
        UserDefaults.standard.set(value, forKey: "TODAY_COUNT_VALUE")
    }
    
    
    static func getTargetCount() -> Int {
        return UserDefaults.standard.integer(forKey: "TARGET_COUNT_VALUE")
    }
    
    static func setTargetCount(value: Int) {
        UserDefaults.standard.set(value, forKey: "TARGET_COUNT_VALUE")
    }
    
    static func getProgress() -> Int {
        let today = getTodayCount()
        let target = getTargetCount()
        if target==0 { return 0 }
        return Int(CGFloat(today) / CGFloat(target) * 100.0)
    }
    
    
    static func addTodayCount(value: Int) {
        var count = getTodayCount()
        count += value
        setTodayCount(value: count)
    }
}
