//
//  ContentView.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @StateObject var addItemVM = AddItemViewModel()
    @StateObject var itemVM = ItemArrayViewModel()
    
    @State var randomItem = ""
    
    var body: some View {
        
        ZStack {
            
            Color.yellow.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                RandomItemWindow().padding(.top, 100)
                
                VStack {
                    
                    NewItemTextField()
                        
                    ItemList(items: self.itemVM.items)
                    
                }.padding(.top, 25)
                
                Spacer()
                
                RandomButton()
                
            }
            
        }
        
    }
    
}
