//
//  NetworkManager.swift
//  networking
//
//  Created by Nikita on 23.08.2022.
//

import Foundation

class NetworkManager {
    
    enum HTTPMethod: String {
        case POST
        case PUT
        case DELETE
        case GET
    }
    
    enum APIs: String {
        case posts
        case users
        case comments
    }
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    func getAllPosts(_ complitionHandler: @escaping ([Post]) -> Void) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("error in getAllPosts")
                } else {
                    if let resp = response as? HTTPURLResponse,
                        resp.statusCode == 200,
                       let responseData = data {
                        let posts = try? JSONDecoder().decode([Post].self, from: responseData)
                        
                        complitionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
    
    func postCreatePost(_ post: Post, complitionHandler: @escaping (Post) -> Void) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue),
        let data = try? JSONEncoder().encode(post) else { return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Lengh")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("error in postCreatePost")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 201, let responseData = data {
                
                if let responsePost = try? JSONDecoder().decode(Post.self, from: responseData) {
                    complitionHandler(responsePost)
                }
            }
        }.resume()
    }
    
    func getPostsBy(userId: Int, complitionHandler: @escaping ([Post]) -> Void) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        
        guard let queryUrl = components?.url else { return }
        
        URLSession.shared.dataTask(with: queryUrl) { (data, response, error) in
            
            if error != nil {
                print("error getPostBy")
            } else if let resp = response as? HTTPURLResponse,
                      resp.statusCode == 200,
                      let reciveData = data {
                
                let posts = try? JSONDecoder().decode([Post].self, from: reciveData)
                
                complitionHandler(posts ?? [])
            }
        }.resume()
    }
}
