//
//  PrioritySelector.swift
//  notes
//
//  Created by Shivam Dhuria on 09/02/21.
//

import SwiftUI

struct PrioritySelector: View {
    
    
    @Binding var priority: TaskPriority
    @State var selections = Array(repeating: false, count: TaskPriority.allCases.count)
    
    var body: some View {
      List {
        ForEach(0..<TaskPriority.allCases.count) { index in
          Button(action: {
            self.priority = TaskPriority.allCases[index]
            self.selections = Array(repeating: false, count: TaskPriority.allCases.count)
            self.selections[index] = true
          }) {
            HStack {
              Text(TaskPriority.allCases[index].fullDisplay)
              Spacer()
              
              if self.selections[index] == true {
                Image(systemName: "checkmark")
              }
            }
          }
        }
      }
    }
}

struct PrioritySelector_Previews: PreviewProvider {
    static var previews: some View {
        PrioritySelector(priority: .constant(.none))
    }
}
