//
//  Item+CoreDataProperties.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import CoreData

extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
    
    @NSManaged public var itemString: String?
    @NSManaged public var itemUUID: UUID?
    
    public var wrappedItemString: String {
        itemString ?? "Unkown title"
    }
    
}
