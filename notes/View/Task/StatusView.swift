//
//  StatusView.swift
//  notes
//
//  Created by Shivam Dhuria on 11/02/21.
//

import SwiftUI

struct StatusView: View {
    @Binding var isChecked: Bool
    
    var body: some View {

        Circle()
            .padding(4)
            .overlay(
                Circle()
                    .stroke(Color.red, lineWidth: 2)
            )
            .foregroundColor(isChecked ? .red : .clear)
            .frame(width:20, height: 20)
    }
    
    struct StatusView_Previews: PreviewProvider {
        static var previews: some View {
            StatusView(isChecked: .constant(true)).previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
