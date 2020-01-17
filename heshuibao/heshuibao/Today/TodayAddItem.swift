//
//  TodayAddItem.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/23.
//  Copyright © 2019 erlingerling. All rights reserved.
//
/**
 1. 图片名称
 2. 饮品名称
 3. 时间 HH：mm
 4. 毫升
 5. 进度
 */
import UIKit

class TodayAddItem: NSObject, NSCoding {
    
    override init() {
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(imgName, forKey: "today_imgName")
        coder.encode(waterName, forKey: "today_waterName")
        coder.encode(time, forKey: "today_time")
        coder.encode(mlValue, forKey: "today_mlValue")
        coder.encode(progress, forKey: "today_progress")
    }
    
    required init?(coder: NSCoder) {
        imgName = coder.decodeObject(forKey: "today_imgName") as! String
        waterName = coder.decodeObject(forKey: "today_waterName") as! String
        time = coder.decodeObject(forKey: "today_time") as! String
        mlValue = coder.decodeObject(forKey: "today_mlValue") as! String
        progress = coder.decodeInteger(forKey: "today_progress")
    }
    
    // 属性
    var imgName: String = ""
    var waterName: String = ""
    var time: String = ""
    var mlValue: String = ""
    var progress: Int = 0
    
    
    //
    func my_print() {
        print(("\(imgName) --- \(waterName) --- \(time) -- \(mlValue) -- \(progress)"))
    }
    
    // 添加
    func Add() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        var itemArr = UserDefaults.standard.array(forKey: "TODAY_ADD_ITEM_KEY")
        if itemArr == nil {
            itemArr = Array()
            UserDefaults.standard.set(itemArr, forKey: "TODAY_ADD_ITEM_KEY")
        }
        itemArr?.append(data)
        UserDefaults.standard.set(itemArr, forKey: "TODAY_ADD_ITEM_KEY")
        
        print(UserDefaults.standard.array(forKey: "TODAY_ADD_ITEM_KEY")?.count ?? "-1")
    }
    
    // 读取
    static func GetTodayItemArray() -> Array<TodayAddItem> {
        
        var itemArr = UserDefaults.standard.array(forKey: "TODAY_ADD_ITEM_KEY")
        if itemArr == nil {
            itemArr = Array()
            UserDefaults.standard.set(itemArr, forKey: "TODAY_ADD_ITEM_KEY")
        }
        
        
        var array = Array<TodayAddItem>()
        for i in 0..<itemArr!.count {
            let data = itemArr![i]
            let item = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! TodayAddItem
            array.append(item)
        }
        
        
        return array
    }
    
    // 删除全部
    static func RemoveAllItem() {
        UserDefaults.standard.set(Array<TodayAddItem>(), forKey: "TODAY_ADD_ITEM_KEY")
    }
}
