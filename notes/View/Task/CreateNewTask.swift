//
//  CreateNewTask.swift
//  notes
//
//  Created by Shivam Dhuria on 08/02/21.
//

import SwiftUI

public enum TaskPriority: Int16 , CaseIterable{
    case none = 0
    case low = 1
    case medium = 2
    case high = 3
}

extension TaskPriority {
    var shortDisplay: String {
        switch self {
        case .none: return ""
        case .low: return "!"
        case .medium: return "!!"
        case .high: return "!!!"
        }
    }
    
    var fullDisplay: String {
        switch self {
        case .none: return "None"
        case .low: return "Low"
        case .medium: return "Medium"
        case .high: return "High"
        }
    }
}


struct CreateNewTask: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    let group: Group
    
    
    @State var note: String = ""
    @State var priority: TaskPriority = .none
    @State var dueDate = Date()
    
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Task", text: $note)
                        .frame(height: 55)
                }
                Section{
                    NavigationLink(destination: PrioritySelector(priority: $priority)) {
                        Text("Priority")
                        Spacer()
                        Text(priority.fullDisplay)
                    }
                }
                
            }
            
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle(Text("Create New Task"), displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print(note)
                                        Task.createWith(title: self.note, priority: self.priority.rawValue, in:self.group, using: self.viewContext )
                                        self.presentationMode.wrappedValue.dismiss()
                                    }) {
                                        Text("Save")
                                            .fontWeight(.bold)
                                    })
        }
        
    }
    
    //    private func addTask(title: String, priority: TaskPriority){
    //        withAnimation(){
    //            let newTask = Task(context: viewContext)
    //            newTask.title = title
    //            newTask.isCompleted = false
    //            newTask.dueData = Date()
    //            newTask.priority = priority.rawValue
    //            saveContext()
    //        }
    //
    //    }
    
//    private func saveContext(){
//        do {
//            try viewContext.save()
//        } catch  {
//            let error = error as NSError
//            fatalError("Unresolved \(error)")
//        }
//    }
}

struct CreateNewTask_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.shared.container.viewContext
        let newGroup = Group(context: viewContext)
        newGroup.title = "poop"
        return  CreateNewTask(group: newGroup)
            .environment(\.managedObjectContext, viewContext)
    }
}
