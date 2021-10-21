//
//  Crumb+CoreDataProperties.swift
//  LeftoversApp
//
//  Created by 109895 on 8.10.2021.
//
//

import Foundation
import CoreData


extension Crumb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crumb> {
        return NSFetchRequest<Crumb>(entityName: "Crumb")
    }

    @NSManaged public var content: String?
    @NSManaged public var contentType: Int32
    @NSManaged public var createDate: Date?
    @NSManaged public var due: Date?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var priority: Int32

}

extension Crumb : Identifiable {

}
