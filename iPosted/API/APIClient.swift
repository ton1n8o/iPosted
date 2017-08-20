//
//  APIClient.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation
import WebKit

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
            // in case something goes wrong here, we'll detect during development cycle
            fatalError()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        session.dataTask(with: url) { [weak self] (data, response, error)  in
            
            guard error == nil else {
                self?.turnOffNetworkActivityIndicator()
                completion(nil, WebserviceError.responseError)
                return
            }
            
            guard let data = data else {
                self?.turnOffNetworkActivityIndicator()
                completion(nil, WebserviceError.dataEmptyError)
                return
            }
            
            var users: [User]? = nil
            
            do {
                
                guard let dictUsers = try JSONSerialization.jsonObject(with: data, options: []) as?
                    [[String: AnyObject]] else {
                    completion(nil, WebserviceError.jsonResponseNotCompaitble)
                    return
                }
                
                users = [User]()
                for dict in dictUsers {
                    users?.append(User(dict: dict))
                }
                
                self?.turnOffNetworkActivityIndicator()
                completion(users, nil)
                
            } catch {
                self?.turnOffNetworkActivityIndicator()
                completion(users, error)
            }
            
        }.resume()
    }
    
    /// Fetch user posts from the __APIEndpoints.swift__
    ///
    /// - Parameter completion: completion description
    func loadPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        
        let urlPosts = "\(APIEndpoints.POSTS)?userId=\(userId)"
        guard let url = URL(string: urlPosts) else {
            // in case something goes wrong here, we'll detect during development cycle
            fatalError()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard error == nil else {
                self?.turnOffNetworkActivityIndicator()
                completion(nil, WebserviceError.responseError)
                return
            }
            
            guard let data = data else {
                self?.turnOffNetworkActivityIndicator()
                completion(nil, WebserviceError.dataEmptyError)
                return
            }
            
            var posts: [Post]? = nil
            
            do {
                
                guard let dictPosts = try JSONSerialization.jsonObject(with: data, options: []) as?
                    [[String: AnyObject]] else {
                        completion(nil, WebserviceError.jsonResponseNotCompaitble)
                        return
                }
                
                posts = [Post]()
                for dict in dictPosts {
                    posts?.append(Post(dict: dict))
                }
                
                self?.turnOffNetworkActivityIndicator()
                completion(posts, nil)
                
            } catch {
                self?.turnOffNetworkActivityIndicator()
                completion(nil, error)
            }
            
        }.resume()
        
    }
    
    fileprivate func turnOffNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

protocol SessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {
    
}
