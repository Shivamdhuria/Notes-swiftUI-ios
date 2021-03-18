//
//  TasksView.swift
//  notes
//
//  Created by Shivam Dhuria on 10/02/21.
//

import SwiftUI

struct TasksView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(sortDescriptors: [])
//    var tasks: FetchedResults<Task>
    
//    let fetchRequest = Task.completedRemindersFetchRequest()
  
    var fetchRequest: FetchRequest<Task>
    var tasks: FetchedResults<Task> { return fetchRequest.wrappedValue }
    
    @State var isShowingCreateTaskModal: Bool = false
    let group : Group
    var body: some View {
           
        VStack{
            List{
                ForEach(self.tasks, id: \.self){ task in
                    //                        TaskRow(task: task)
                    TaskRow(task: task)
                    
                }
            }
            HStack {
                AddNewTaskButton(isShowingCreateModal: $isShowingCreateTaskModal, group: self.group)
                Spacer()
            }
            
        }.navigationTitle(group.title ?? "Tasks")
    }
    
    init(group: Group) {
        self.group = group
        self.fetchRequest = Task.group(in: group)
    }
    
    
}

struct AddNewTaskButton: View {
    
    @Binding var isShowingCreateModal : Bool
    let group: Group
    
    var body: some View {
        Button(action: {
            self.isShowingCreateModal.toggle()
        }) {
            HStack{
                Spacer()
                VStack(alignment: .center){
                    Image(systemName:"pencil.tip.crop.circle.badge.plus")
                        .foregroundColor(Color("AccentColor"))
                        .font(.system(size: 50))
                    Text("Add New Task")
                        .font(.title2)
                        .foregroundColor(Color("AccentColor"))
                }
                Spacer()
            }
        }.sheet(isPresented: $isShowingCreateModal) {
            CreateNewTask(group: group)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(.vertical, 8)
    }
}

struct TasksView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        TasksView()
    //    }
    static var previews: some View {
        
        let viewContext = PersistenceController.shared.container.viewContext
        let newTask = Group(context: viewContext)
        newTask.title = "check"
        
        return  TasksView(group: newTask)
            .environment(\.managedObjectContext, viewContext)
    }
}
