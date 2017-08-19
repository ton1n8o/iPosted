//
//  Company.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Company : Equatable {
    
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    init(dict: [String : AnyObject]) {
        self.name = JSONParserHelper.shared.parseString(dict["name"])
        self.catchPhrase = JSONParserHelper.shared.parseString(dict["catchPhrase"])
        self.bs = JSONParserHelper.shared.parseString(dict["bs"])
    }
    
}

extension Company {
    
    static func ==(rhs: Company, lhs: Company) -> Bool {
        if rhs.name != lhs.name {
            return false
        }
        if rhs.catchPhrase != lhs.catchPhrase {
            return false
        }
        if rhs.bs != lhs.bs {
            return false
        }
        return true
    }
}
