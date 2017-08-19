//
//  User.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct User : Equatable {
    
    let id: Int
    let name: String
    let userName: String
    let email: String
    let address: Address?
    let phone: String
    let website: String
    let company: Company?
    
    init(id: Int, name: String, userName: String, email: String, address: Address?,
         phone: String, website: String, company: Company?) {
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
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

extension User {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        if lhs.name != rhs.name {
            return false
        }
        if lhs.userName != rhs.userName {
            return false
        }
        if lhs.email != rhs.email {
            return false
        }
        if lhs.address != rhs.address {
            return false
        }
        if lhs.phone != rhs.phone {
            return false
        }
        if lhs.website != rhs.website {
            return false
        }
        if lhs.company != rhs.company {
            return false
        }
        return true
    }
    
}
