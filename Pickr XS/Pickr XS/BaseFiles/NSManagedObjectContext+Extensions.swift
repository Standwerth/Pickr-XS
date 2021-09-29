//
//  NSManagedObjectContext+Extensions.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import CoreData
import UIKit

extension NSManagedObjectContext {
    static var current : NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}

