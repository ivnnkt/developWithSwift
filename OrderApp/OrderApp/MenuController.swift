//
//  MenuController.swift
//  OrderApp
//
//  Created by Nikita on 07.07.2022.
//

import Foundation
import UIKit

// MARK: - network requests
class MenuController {

    static let shared = MenuController()
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    let baseURL = URL(string: "http://localhost:8080/")!
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    typealias MinutesToPrepare = Int
    
    enum MenuControllerError: Error, LocalizedError {
        case categoriesNotFound
        case menuItemsNotFound
        case orderRequestFailed
        case imageDataMissing
    }
    
//    GET request to fetch Categories
    func fetchCategories() async throws -> [String] {
        //preparing URL for request
        let categoriesURL = baseURL.appendingPathComponent("categories")
        //request data
        let (data, response) = try await URLSession.shared.data(from: categoriesURL)
        //response validation
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.categoriesNotFound
        }
        //decoding response data
        let decoder = JSONDecoder()
        let categoriesResponse = try decoder.decode(CategoryResponse.self, from: data)
        
        return categoriesResponse.categories
    }
    
//    GET request to fetch MenuItems by category
    func fetchMenuItems(forCategories categoryName: String) async throws -> [MenuItem] {
        //preparing URL for request
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        //request data
        let (data, response) = try await URLSession.shared.data(from: menuURL)
        //response validation
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.menuItemsNotFound
        }
        //decoding response data
        let decoder = JSONDecoder()
        let menuResponse = try decoder.decode(MenuResponse.self, from: data)
        
        return menuResponse.items
    }
    
//    POST request to create an order. Return amound of minutes was needed to prepare the order
    func submitOrder(forMenuIds menuIDs: [Int]) async throws -> MinutesToPrepare {
        //preparing URL for requeset
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let menuIdsDict = ["menuIds": menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(menuIdsDict)
        request.httpBody = jsonData
        //request data
        let (data, response) = try await URLSession.shared.data(for: request)
        //response validation
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.orderRequestFailed
        }
        //decoding response data
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrderResponse.self, from: data)
        
        return orderResponse.prepTime
    }
    
//    GET request to fetch Image
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw MenuControllerError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw MenuControllerError.imageDataMissing
        }
        
        return image
    }
}
