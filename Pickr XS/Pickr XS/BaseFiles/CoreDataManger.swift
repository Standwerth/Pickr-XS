//
//  CoreDataManger.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    // MARK: - Item C.R.U.D
    
    func saveItem(itemString: String, itemUUID: UUID) {
        
        let item = Item(context: self.moc)
        item.itemString = itemString
        item.itemUUID = itemUUID
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
     
    }
    
    func deleteItem(itemString: String){
        do {
            if let item = fetchItem(itemString: itemString){
                self.moc.delete(item)
                try self.moc.save()
            }
        } catch let error as NSError {
            print(error)
        }
    }
  
    
    func fetchAllItems() -> [Item] {
        var items = [Item]()
        
        let itemsRequest : NSFetchRequest<Item>  = Item.fetchRequest()
        
        do {
            items = try self.moc.fetch(itemsRequest)
        } catch let error as NSError {
            print(error)
        }
        
        return items
    }
    
    func fetchItem(itemString:String) -> Item? {
        var items    = [Item]()
        
        let request: NSFetchRequest<Item>    = Item.fetchRequest()
        request.predicate    = NSPredicate(format: "itemString == %@", itemString)
        
        do {
            items = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return items.first
    }
    
}
