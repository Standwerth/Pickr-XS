//
//  NewItemTextField.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import Foundation
import SwiftUI


struct NewItemTextField: View {
    
    @StateObject var addItemVM = AddItemViewModel()
    
    var body: some View {
        
        HStack {
            
            TextField("Enter something", text: self.$addItemVM.itemString)
            
            Button(action: {
                
                self.addItemVM.addItem()

                
            }) {
                
                Image(systemName: "plus")
                    .foregroundColor(.black)
                
            }
            
        }.padding()
        .background(Color.white)
        .cornerRadius(25)
        .padding(.horizontal, 55)
    
    }
    
}


