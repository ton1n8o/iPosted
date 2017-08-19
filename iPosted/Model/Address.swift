//
//  Address.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Address : Equatable {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo?
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo?) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    init(dict: [String : AnyObject]) {
        self.street = JSONParserHelper.shared.parseString(dict["street"])
        self.suite = JSONParserHelper.shared.parseString(dict["suite"])
        self.city = JSONParserHelper.shared.parseString(dict["city"])
        self.zipcode = JSONParserHelper.shared.parseString(dict["zipcode"])
        
        if let dictGeo = JSONParserHelper.shared.stract(fromDict: dict, "geo") {
           self.geo = Geo(dict: dictGeo)
        } else {
           self.geo = nil
        }
        
    }
}

extension Address {
    
    static func ==(rhs: Address, lhs: Address) -> Bool {
        if rhs.street != lhs.street {
            return false
        }
        if rhs.suite != lhs.suite {
            return false
        }
        if rhs.city != lhs.city {
            return false
        }
        if rhs.zipcode != lhs.zipcode {
            return false
        }
        if rhs.geo != lhs.geo {
            return false
        }
        return true
    }
}
