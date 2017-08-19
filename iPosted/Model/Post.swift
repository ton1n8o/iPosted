//
//  Post.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Post : Equatable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    init(dict: [String : AnyObject]) {
        self.userId = JSONParserHelper.shared.parseInt(dict["userId"])
        self.id = JSONParserHelper.shared.parseInt(dict["id"])
        self.title = JSONParserHelper.shared.parseString(dict["title"])
        self.body = JSONParserHelper.shared.parseString(dict["body"])
    }
}

extension Post {
    
    static func ==(rhs: Post, lhs: Post) -> Bool {
        if rhs.userId != lhs.userId {
            return false
        }
        if rhs.id != lhs.id {
            return false
        }
        if rhs.title != lhs.title {
            return false
        }
        if rhs.body != lhs.body {
            return false
        }
        return true
    }
    
}
