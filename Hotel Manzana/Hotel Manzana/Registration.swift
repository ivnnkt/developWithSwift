//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Nikita on 28.04.2022.
//

import Foundation

// Define Registration model
struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var wifi: Bool
    var roomType: RoomType
}
