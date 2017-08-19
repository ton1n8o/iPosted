//
//  Geo.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct Geo : Equatable {
    
    let lat, lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(dict: [String : AnyObject]) {
        self.lat = JSONParserHelper.shared.parseDouble(dict["lat"])
        self.lng = JSONParserHelper.shared.parseDouble(dict["lng"])
    }
    
}

extension Geo {
    static func ==(rhs: Geo, lhs: Geo) -> Bool {
        if rhs.lat != lhs.lat {
            return false
        }
        if rhs.lng != lhs.lng {
            return false
        }
        return true
    }
}
