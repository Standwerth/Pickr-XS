//
//  ItemList.swift
//  Pickr XS
//
//  Created by Anton Standwerth on 2021-09-23.
//

import SwiftUI
import Combine

struct ItemList: View {
    
    @ObservedObject var itemVM = ItemArrayViewModel()
    
    var items: [ItemViewModel]
    
    // An array containing an array of ItemViewModel within it (chunking arrays).
    var groupedItems: [[ItemViewModel]] = [[ItemViewModel]]()
    
    init(items: [ItemViewModel]) {
        
        // All the instances inside the array containing the ItemViewModels.
        self.items = items
        
        // The groupedItems variable is assigned to the function createGroupedItems, which accepts a parameter of type [ItemViewModel] and returns a value of [[ItemViewModel]]
        self.groupedItems = createGroupedItems(items)
        
    }
    
    private func createGroupedItems(_ items: [ItemViewModel]) -> [[ItemViewModel]] {
        
        // The value that is being returned.
        var groupedItems: [[ItemViewModel]] = [[ItemViewModel]]()
        
        // The item that is extranous when yhe maxWidth is exceded.
        var tempItems: [ItemViewModel] = [ItemViewModel]()
        var width: CGFloat = 0
        let spacingWidth: CGFloat = 32
        let deleteBtnWidth: CGFloat = 15
        
        // string is each unique element inside the collection. In other words each ItemViewModel inside the array of ItemViewModels.
        for string in items {
            
            // During the iteration assign every entry a unique UILabel, and then later change the text of that label to that of the entry (itemString)
            let label = UILabel()
            label.text = string.itemString
            label.sizeToFit()
            
            // CGFloat value for the width of the label. +32 to inidicate that we want some space between each entry/instance. The 15 is to represent the space that the delete button takes up.
            let labelWith = (label.frame.size.width + spacingWidth + deleteBtnWidth)
            
            // If the width (which is the total width from all previous labels on that specific row) + the current label + 32 is less then the total width of the screen.
            if (width + labelWith + spacingWidth + deleteBtnWidth) < (getWidth() - 50) {
                
                // Add the width of the label to the total width. (In other words since the width wouldn't be greater then the total screen with it is now okay to add the width of the current label to the total width.
                width += labelWith
                
                // Adding the current item to the current row (tempItems).
                tempItems.append(string)
                
            } else {
                
                // If the labelWidth is too wide and exceeds the screen width, the width will be assigned the labelWidth.
                width = labelWith
                
                // The array of full row of items (tempItems) will be appended to the groupedItems which is an array containing arrays of ItemViewModels, where a row is represented as a signle array. For example
                
                // [[row1], [row2], [row3]]. Where each row is of type [ItemViewModel]
                groupedItems.append(tempItems)
                
                // In order to prepare a new row, we first appended the current row which is full to the groupedItems array, which is of type [[ItemViewModel]]. Once the tempItems area added and secured we clear the tempItems to prepare the new row, which will start off by containing the current ItemViewModel
                tempItems.removeAll()
                
                // Here we append the current item to the tempItems, indicating a new row.
                tempItems.append(string)
                
            }
            
        }
        
        // The groupedItems still need to append the row that is not full, by adding it to the groupedItems as well. However the tempItems are still untouched, meaning we still know that there is a current row that is not empty nor full, and which will be used to check when adding the next item to the list.
        groupedItems.append(tempItems)
        return groupedItems
        
    }
    
    var body: some View {
        
        ScrollView() {
            
            VStack(alignment: .leading) {
                
                ForEach(groupedItems, id: \.self) { subItems in
                    
                    HStack {
                        
                        ForEach(subItems, id: \.self) { item in
                            
                            HStack {
                                
                                Text(item.itemString)
                                    .font(.custom("HeadingProTrial-Light", size: 15))
                                    .lineLimit(0)
                                
                                Button(action: {
                                    
                                    self.itemVM.deleteItem(itemVM: item)
                                    self.itemVM.getAllItems()
                                    
                                }) {
                                    
                                    Image(systemName: "multiply")
                                        .foregroundColor(.black)
                                    
                                }
                                
                            }.padding([.horizontal, .vertical], 7)
                            .background(Color.white)
                            .cornerRadius(25)
                            
                        }
                        
                    }
                    
                }
                
            }.padding(.horizontal, 50)
            .padding(.top, 15)
            
        }.frame(width: getWidth(), height: (getWidth() * 0.5), alignment: .center)
        
    }
    
}

extension View {
    
    func getWidth() -> CGFloat {
        
        return UIScreen.main.bounds.width
        
    }
    
    func getHeight() -> CGFloat {
        
        return UIScreen.main.bounds.height
        
    }
    
}

