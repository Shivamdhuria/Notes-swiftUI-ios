//
//  Group+CoreDataProperties.swift
//  notes
//
//  Created by Shivam Dhuria on 10/02/21.
//
//

import Foundation
import CoreData
import SwiftUI


extension Group {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var color: String?
    @NSManaged public var icon: String?
    @NSManaged public var tasks: Array<Task>?
    
    
    static func create(withTitke title: String,color: String, icon: String,
                       in context: NSManagedObjectContext){
        
        let group = Group(context: context)
        group.title = title
        group.icon = icon
        group.color = color
        
        do {
            try context.save()
        } catch  {
            let error = error as NSError
            fatalError("Unresolved \(error)")
        }
    }
    
//    static func basicFetchRequest() -> FetchRequest<Group> {
//        FetchRequest(entity: Group.entity(), sortDescriptors: [])
//    }
    
}
