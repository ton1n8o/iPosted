//
//  APIClient.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

enum WebserviceError: Error {
    case dataEmptyError
    case responseError
    case jsonResponseNotCompaitble
}

class APIClient {
    
    lazy var session: SessionProtocol = URLSession.shared
    
    /// Fetch users from the users __APIEndpoints.swift__
    ///
    /// - Parameter completion: completion description
    func loadUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        guard let url = URL(string: APIEndpoints.USERS) else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, WebserviceError.responseError)
                return
            }
            
            guard let data = data else {
                completion(nil, WebserviceError.dataEmptyError)
                return
            }
            
            var users: [User]? = nil
            
            do {
                
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as?
                    [[String: AnyObject]] else {
                    completion(nil, WebserviceError.jsonResponseNotCompaitble)
                    return
                }
                
                users = [User]()
                for d in dict {
                    users?.append(User(dict: d))
                }
                
                completion(users, nil)
                
            } catch {
                completion(users, error)
            }
            
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
