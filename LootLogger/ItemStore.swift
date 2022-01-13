//
//  ItemStore.swift
//  LootLogger
//
//  Created by Michael Worden on 1/11/22.
//

import UIKit

class ItemStore  {

    var allItems = [Item]()
    var highdollarItems = [Item]()
    var lowdollarItems = [Item]()
    var sectionTitles = [String]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        if (newItem.valueInDollars >= 75) {
            highdollarItems.append(newItem)
        } else {
            lowdollarItems.append(newItem)
        }
        return newItem
    }
    init() {
      sectionTitles = ["High Dollar Items", "Low Dollar Items"]
        
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }

        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]

        // Remove item from array
        allItems.remove(at: fromIndex)

        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }

   

}


