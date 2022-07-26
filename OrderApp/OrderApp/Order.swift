//
//  Order.swift
//  OrderApp
//
//  Created by Nikita on 07.07.2022.
//

import Foundation

// Define Order model
struct Order: Codable {
    
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}

