//
//  RecordItrem+CoreDataProperties.swift
//  
//
//  Created by 舒蕾 on 2019/12/30.
//
//

import Foundation
import CoreData


extension RecordItrem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordItrem> {
        return NSFetchRequest<RecordItrem>(entityName: "RecordItrem")
    }

    @NSManaged public var mlVlalue: Int64
    @NSManaged public var date: Date?
    @NSManaged public var progress: Int64

}
