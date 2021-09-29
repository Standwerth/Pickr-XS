//
//  AddItemViewModel.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import SwiftUI
import Combine

class AddItemViewModel: ObservableObject {
    
    var itemString: String = ""
    var itemUUID = UUID()

    func addItem() {
        CoreDataManager.shared.saveItem(itemString: self.itemString, itemUUID: self.itemUUID)
    }
    
}

