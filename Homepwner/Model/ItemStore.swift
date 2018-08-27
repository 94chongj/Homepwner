//
//  ItemStore.swift
//  Homepwner
//
//  Created by Jonathan Chong on 8/23/18.
//  Copyright © 2018 Jonathan Chong. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    /*var highValueItems: [Item] {
        return allItems.filter{$0.valueInDollars > 50}
    }
    
    var otherItems: [Item] {
        return allItems.filter{$0.valueInDollars <= 50}
    }*/
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        //Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //Remove item from array
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location
        allItems.insert(movedItem, at:toIndex)
    }
    
}
