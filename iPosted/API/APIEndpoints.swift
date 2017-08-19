//
//  APIEndpoints.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct APIEndpoints {
    
    private init() {}
    
    public static let BASE = "https://jsonplaceholder.typicode.com"
    public static let USERS = "\(BASE)/users"
    public static let POSTS = "\(BASE)/posts"
}
