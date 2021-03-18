//
//  ContentView.swift
//  notes
//
//  Created by Shivam Dhuria on 08/02/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //    @FetchRequest(sortDescriptors: [])
    //    var tasks: FetchedResults<Task>
    
    @FetchRequest(sortDescriptors: [])
    var groups: FetchedResults<Group>
    
    
    //    var tasks: [Task] = testDataTasks
    
    
    @State var isShowingCreateGroupModal: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green]
    
    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    let items = 1...10
    
    var body: some View {
        
        NavigationView{
            VStack(){
                
                //                AddNewTaskButton(isShowingCreateModal: $isShowingCreateModal)
               
                ScrollView {
                    LazyVGrid(columns: gridItemLayout, spacing: 30) {
                        ForEach(self.groups, id: \.self) { group in
                            NavigationLink(
                                destination: TasksView(group: group)){
                                GroupRow(group: group)
                            }
                            
                        }
                    }.padding(.top,50.0)
                    .padding(.leading,10.0)
                    .padding(.trailing,10.0)
                }
                
                
            }
           
            .navigationBarTitle("Groups")
           
            .navigationBarItems(trailing: Button("Add Group"){
                isShowingCreateGroupModal.toggle()
            }.sheet(isPresented: $isShowingCreateGroupModal) {
                CreateNewGroup()
            }
            )
            
        }.background(Color("BackgroundColor"))
    }
    
    //    private func deleteTask(offset: IndexSet){
    //        withAnimation(){
    //            print(offset)
    //            offset.map{tasks[$0]}.forEach(viewContext.delete) }
    //    }
    
    private func addTask(){
        withAnimation(){
            let newTask = Task(context: viewContext)
            newTask.title = "New"
            newTask.isCompleted = false
            newTask.dueData = Date()
            saveContext()
        }
        
    }
    
    private func saveContext(){
        do {
            try viewContext.save()
        } catch  {
            let error = error as NSError
            fatalError("Unresolved \(error)")
        }
    }
}

struct GroupRow: View {
    let group : Group
    var body: some View {
        

            VStack{
                HStack{
                    
                    VStack{
                ZStack{
                    
                    Image(systemName:"circle.fill")
                        .foregroundColor(Color(hex: group.color ?? "0000FF"))
                        .font(.system(size: 40))
                    
                    Image(systemName:group.icon ?? "list.bullet")
                        .foregroundColor(.white)
                        .font(.system(size: 20))

                }
                        Text(group.title ?? "Untitled").font(.body)
                            .foregroundColor(Color("TextColor"))
                            .bold()
                    }
                    Spacer()
                  
                    Text("21").font(.subheadline).foregroundColor(Color("TextColor"))
                }

                
              
                Spacer()
                
            }

        .padding()
    
        .background(Color("SurfaceColor"))
        .cornerRadius(13.0)
        .frame(width:160, height: 110)
        .shadow(radius: 15 )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
        
    }
}



