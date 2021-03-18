//
//  notesApp.swift
//  notes
//
//  Created by Shivam Dhuria on 08/02/21.
//

import SwiftUI

@main
struct notesApp: App {
    
    let persistanceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistanceContainer.container.viewContext)
        }
    }
}
