//
//  RandomButton.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-27.
//

import SwiftUI

struct RandomButton: View {
    
    @ObservedObject var itemVM = ItemArrayViewModel()
    
    var body: some View {
        
        Button(action: {
            
            print(itemVM.randomItem())
            
        }) {
            
            Text("Shuffle")
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .font(.bold(.subheadline)())
                .cornerRadius(25)
            
        }
        
    }
}

