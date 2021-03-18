//
//  CreateNewGroup.swift
//  notes
//
//  Created by Shivam Dhuria on 09/02/21.
//

import SwiftUI

struct CreateNewGroup: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var groupName: String = ""
    @State private var bgColor = Color.blue
    @State private var groupImage = "list.bullet"
    
    let symbols : [String] = [
        "pencil.circle","pencil.circle.fill","pencil.slash","rectangle.and.pencil.and.ellipsis",
        "xmark.bin","doc.circle","command.square","alt","shift.fill","escape","wake","bicycle.circle","viewfinder","gamecontroller","applelogo",
        "keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    let colors : [String] = [
        "pencil.circle","pencil.circle.fill","pencil.slash","rectangle.and.pencil.and.ellipsis",
        "xmark.bin","doc.circle","command.square","alt","shift.fill","escape","wake","bicycle.circle","viewfinder","gamecontroller","applelogo",
        "keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    //    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                ZStack{
                    
                    Image(systemName:"circle.fill")
                        .foregroundColor(bgColor)
                        .font(.system(size: 90))
                        .shadow(radius: 20)
                        .padding()
                    
                    Image(systemName:groupImage)
                        .foregroundColor(Color(.white))
                        .font(.system(size: 40))
                        .padding()
                    
                }
                
                
                TextField("Group Name", text: $groupName).multilineTextAlignment(.center).font(.title2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .cornerRadius(12.0)
                    .padding()
                
                ColorPicker("Set the background color", selection: $bgColor)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: threeColumnGrid, spacing: 10) {
                        ForEach((0..<symbols.count), id: \.self) { index in
                            HStack{
                                Spacer()
                                Image(systemName: symbols[index])
                                    .font(.system(size: 30))
                                    .frame(width: 100, height: 100)
                                Spacer()
                            }.contentShape(Rectangle())
                            .onTapGesture {
                                groupImage = symbols[index]
                            }
                        }
                        
                    }
                }
                
                
                Spacer()
                
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle(Text("Create New Group"), displayMode: .inline)
            .navigationBarItems(
                leading:   Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()}){
                    Text("Cancel")
                        .fontWeight(.bold)
                },
                
                trailing:Button(action: {
                    let uiColor = UIColor(self.bgColor).toHex()
                    
                    Group.create(withTitke: self.groupName,color: uiColor, icon: self.groupImage, in: viewContext)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .fontWeight(.bold)
                })
        }
        
    }
    
    
}

struct CreateNewGroup_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewGroup()
    }
}
