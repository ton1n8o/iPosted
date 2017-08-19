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
    let address: Address?
    let phone: String
    let website: String
    let company: Company?
    
    init(dict: [String : AnyObject]) {
        self.id = JSONParserHelper.shared.parseInt(dict["id"])
        self.name = JSONParserHelper.shared.parseString(dict["name"])
        self.userName = JSONParserHelper.shared.parseString(dict["username"])
        self.email = JSONParserHelper.shared.parseString(dict["email"])
        
        if let addressDict = JSONParserHelper.shared.stract(fromDict: dict, "address") {
            self.address = Address(dict: addressDict)
        } else {
            self.address = nil
        }
         
        self.phone = JSONParserHelper.shared.parseString(dict["phone"])
        self.website = JSONParserHelper.shared.parseString(dict["website"])
        
        if let companyDict = JSONParserHelper.shared.stract(fromDict: dict, "company") {
            self.company = Company(dict: companyDict)
        } else {
            self.company = nil
        }
    }
}
