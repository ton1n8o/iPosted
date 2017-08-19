//
//  User.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct User {
    
    let id: Int
    let name: String
    let userName: String
    let email: String
    let phone: String
    
    init(dict: [String : AnyObject]) {
        self.id = JSONParserHelper.shared.parseInt(dict["id"])
        self.name = JSONParserHelper.shared.parseString(dict["name"])
        self.userName = JSONParserHelper.shared.parseString(dict["username"])
        self.email = JSONParserHelper.shared.parseString(dict["email"])
        // TODO: address
        self.phone = JSONParserHelper.shared.parseString(dict["phone"])
    }
}
