//
//  ResponseModels.swift
//  OrderApp
//
//  Created by Nikita on 07.07.2022.
//

import Foundation

// for response from "/menu" endpoint
struct MenuResponse: Codable {
    let items: [MenuItem]
}

// for response from "/category" endpoint
struct CategoryResponse: Codable {
    let categories: [String]
}

// for response from "/order" endpoint
struct OrderResponse: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
