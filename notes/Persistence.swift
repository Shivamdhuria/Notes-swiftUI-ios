//
//  Persistence.swift
//  notes
//
//  Created by Shivam Dhuria on 09/02/21.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TaskList")
        
        container.loadPersistentStores{(storeDescription,error) in
            if let error = error as NSError? {
                fatalError("Unresolved errir\(error)")
            }
        }
    }
}
