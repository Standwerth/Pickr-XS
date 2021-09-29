//
//  ItemArrayViewModel.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class ItemArrayViewModel: ObservableObject {
    
    @Published var items = [ItemViewModel]()
    
    init() {
        getAllItems()
    }
    
    func getAllItems() {
        self.items = CoreDataManager.shared.fetchAllItems().map(ItemViewModel.init)
    }
    
    func deleteItem(itemVM: ItemViewModel) {
        CoreDataManager.shared.deleteItem(itemString: itemVM.itemString)
        getAllItems()
    }
    
    func randomItem() -> String {
        let randomItem = items.randomElement()?.itemString
        
        return randomItem ?? "Error"
    }
    
    func fetchItem(itemVM: ItemViewModel) -> Item? {
        CoreDataManager.shared.fetchItem(itemString: itemVM.itemString)
    }
    
}

class ItemViewModel: ObservableObject, Identifiable, Hashable {
    
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        return lhs.itemString == rhs.itemString
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(itemString)
        }
    
    var itemString = ""
    var itemUUID = UUID()

    init(item: Item) {
        self.itemString = item.itemString ?? "Unknown title"
    }

}
