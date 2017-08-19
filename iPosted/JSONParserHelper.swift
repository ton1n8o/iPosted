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
    /// - Returns: a converted int or -1 value.
    func parseInt(_ num: AnyObject?) -> Int {
        guard let num = num as? Int else {
            return -1
        }
        return num
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
    
}
