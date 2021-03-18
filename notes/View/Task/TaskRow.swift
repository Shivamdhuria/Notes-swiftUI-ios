//
//  TaskRow.swift
//  notes
//
//  Created by Shivam Dhuria on 08/02/21.
//

import SwiftUI

struct TaskRow: View {

    @State var isCompleted: Bool = false
    var task: Task
    
    
    private var priority: String {
      TaskPriority(rawValue: task.priority)?.fullDisplay ?? ""
    }
    var body: some View {
      HStack {
        Button(action: {
          self.isCompleted.toggle()
          self.task.isCompleted = self.isCompleted
        }) {
          StatusView(isChecked: $isCompleted)
        }
        Text(task.title ?? "Untitled")
        Spacer()
      }
    }
}



struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewContext = PersistenceController.shared.container.viewContext
        let newTask = Task(context: viewContext)
        newTask.title = "poop"
        newTask.dueData = Date()
        newTask.priority = 2
        return  TaskRow(task: newTask)
            .environment(\.managedObjectContext, viewContext)
            .previewLayout(.fixed(width: 300, height: 70))

    }
}

