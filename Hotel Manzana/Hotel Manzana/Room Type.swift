//
//  Room Type.swift
//  Hotel Manzana
//
//  Created by Nikita on 23.04.2022.
//

import Foundation

// Define RoomType model
struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
        RoomType(id: 1, name: "One King", shortName: "K", price: 209),
        RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
}
