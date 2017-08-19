//
//  Address.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Address {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo?
    
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
