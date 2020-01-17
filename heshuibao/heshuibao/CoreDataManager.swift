//
//  CoreDataManager.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/27.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    // 单例
    static let shared = CoreDataManager()
    
    // 拿到AppDelegate中创建好了的NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()

    
    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // 增加数据
    func saveReordItemWith(date: Date, mlValue: Int64, progress: Int64) {
        let recordItem = NSEntityDescription.insertNewObject(forEntityName: "RecordItrem", into: context) as! RecordItrem
        
        recordItem.date = date
        recordItem.mlVlalue = mlValue
        recordItem.progress = progress
        
        saveContext()
    }
    
    // 获取所有数据
    func getAllRecordItems() -> [RecordItrem] {
        let fetchRequest: NSFetchRequest = RecordItrem.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }

    // 删除所有数据
    func deleteAllRecordItems() {
        // 这里直接调用上面获取所有数据的方法
        let result = getAllRecordItems()
        // 循环删除所有数据
        for item in result {
            context.delete(item)
        }
        saveContext()
    }
    
    // 获取指定日期的数据
    func getItemWithDate(date: Date) -> RecordSnpItem {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "MM/dd"
        
        let items = getAllRecordItems().reversed()
        for item in items {
            if (fmt.string(from: item.date!) == fmt.string(from: date)) {
                //找到了
                let snpItem = RecordSnpItem()
                snpItem.date = item.date
                snpItem.mlVlalue = Int(item.mlVlalue)
                snpItem.progress = Int(item.progress)
                return snpItem
            }
        }
        
        // 没找到 返回一个空的
        let snpItem = RecordSnpItem()
        snpItem.date = date
        snpItem.mlVlalue = 0
        snpItem.progress = -1
        return snpItem
        
//        let recordItem = NSEntityDescription.insertNewObject(forEntityName: "RecordItrem", into: context) as! RecordItrem
//
//        recordItem.date = date
//        recordItem.mlVlalue = 0
//        recordItem.progress = -1
//        return recordItem
    }

}
