//
//  APIClient.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

class APIClient {
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func loadUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        guard let url = URL(string: APIEndpoints.USERS) else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            var users: [User]? = nil
            
            if let dict = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                users = [User]()
                for d in dict {
                    users?.append(User(dict: d))
                }
            }
            
            completion(users, nil)
            
        }.resume()
    }
    
}

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
    
}

extension APIClient {
    
}
