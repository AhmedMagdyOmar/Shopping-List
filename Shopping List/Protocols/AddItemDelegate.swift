//
//  AddItemDelegate.swift
//  Shopping List
//
//  Created by Ahmed  on 13/03/2021.
//  Copyright © 2021 Ahmed. All rights reserved.
//

import Foundation

// instead of request cloud data every time to show the new item . we can showing it by passing with delegte
protocol AddItemDelegte {
    func addNewItem(item:Item)
}
