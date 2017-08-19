//
//  JSONParserHelper.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import Foundation

struct JSONParserHelper {
    
    // singleton instance
    public static let shared = JSONParserHelper()
    
    private init() {}
    
    /// Given an **AnyObject** it tries to cast it to Int, in case it works the
    /// int value is returned otherwise **-1**.
    ///
    /// - Parameter num: AnyObjecto to be converted to Int.
    /// - Returns: a converted int or **-1 value**.
    func parseInt(_ num: AnyObject?) -> Int {
        if let num = num as? Int {
            return num
        }
        if let num = num as? String, let intValue = Int(num) {
            return intValue
        }
        return -1
    }
    
    /// Given an **AnyObject** it tries to cast it to String, in case it works the
    /// string value is returned otherwise an empty string.
    ///
    /// - Parameter str: AnyObjecto to be converted to String.
    /// - Returns: a converted string or an **empty string**.
    func parseString(_ str: AnyObject?) -> String {
        guard let str = str as? String else {
            return ""
        }
        return str
    }
    
    /// Given an **AnyObject** it tries to cast it to Double, in case it works the
    /// double value is returned otherwise -1.
    ///
    /// - Parameter dbl: AnyObjecto to be converted to Double.
    /// - Returns: a converted double or **-1 value**.
    func parseDouble(_ dbl: AnyObject?) -> Double {
        if let dbl = dbl as? Double {
            return dbl
        }
        if let dbl = dbl as? String, let doubleValue = Double(dbl) {
            return doubleValue
        }
        return -1
    }
    
    func stract(fromDict: [String :AnyObject], _ usingkey: String) -> [String :AnyObject]? {
        guard let dict = fromDict[usingkey] as? [String: AnyObject] else {
            return nil
        }
        return dict
    }
    
}
