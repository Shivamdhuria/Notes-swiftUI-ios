//
//  Task+CoreDataProperties.swift
//  notes
//
//  Created by Shivam Dhuria on 10/02/21.
//
//

import Foundation
import CoreData
import SwiftUI


extension Task {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }
    
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var dueData: Date?
    @NSManaged public var priority: Int16
    @NSManaged public var group: Group?
    
    static func createWith(title: String,
                           priority: Int16,
                           in group: Group,
                           using context: NSManagedObjectContext) {
        let task = Task(context: context)
        task.title = title
        task.isCompleted = false
        task.dueData = Date()
        task.priority = priority
        task.group = group
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func basicFetchRequest() -> FetchRequest<Task> {
        FetchRequest(entity: Task.entity(), sortDescriptors: [])
    }
    
    static func sortedFetchRequest() -> FetchRequest<Task> {
        let dateSortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        return FetchRequest(entity: Task.entity(), sortDescriptors: [dateSortDescriptor])
    }
    
    static func fetchRequestSortedByTitleAndPriority() -> FetchRequest<Task> {
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: false)
        
        return FetchRequest(entity: Task.entity(), sortDescriptors: [titleSortDescriptor, prioritySortDescriptor])
    }
    
    static func completedRemindersFetchRequest() -> FetchRequest<Task> {
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: false)
        
        let isCompletedPredicate = NSPredicate(format: "%K == %@", "isCompleted", NSNumber(value: false))
        
        return FetchRequest(entity: Task.entity(), sortDescriptors: [titleSortDescriptor, prioritySortDescriptor], predicate: isCompletedPredicate)
    }
    
    static func group(in group: Group) -> FetchRequest<Task> {
        let titleSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let prioritySortDescriptor = NSSortDescriptor(key: "priority", ascending: false)
        let groupPredicate = NSPredicate(format: "%K == %@", "group.title", group.title!)
        let isCompletedPredicate = NSPredicate(format: "%K == %@", "isCompleted", NSNumber(value: false))
        
        let combinedPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [groupPredicate,isCompletedPredicate])
        
        
        return FetchRequest(entity: Task.entity(), sortDescriptors: [titleSortDescriptor, prioritySortDescriptor], predicate: combinedPredicate)
    }    }



//extension Task : Identifiable {
//
//}
