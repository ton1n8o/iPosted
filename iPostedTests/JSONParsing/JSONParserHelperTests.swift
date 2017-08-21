//
//  JSONParserHelperTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class JSONParserHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ParseInt_Returns_IntValue() {
        let num = 1 as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseInt(num), 1)
    }
    
    func test_ParseInt_When_NotInt_Returns_MinusOne() {
        let num = "foo" as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseInt(num), -1)
    }
    
    func test_ParseInt_When_StringInt_Returns_IntValue() {
        let num = "100" as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseInt(num), 100)
    }
    
    func test_ParseString_Returns_StringValue() {
        let str = "Hello" as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseString(str), "Hello")
    }
    
    func test_ParseString_WhenNotString_Returns_EmptyString() {
        let str = 85.7 as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseString(str), "")
    }
    
    func test_ParseDouble_Returns_Double() {
        let dbl = 85.78421 as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseDouble(dbl), 85.78421)
    }
    
    func test_ParseDouble_DoubleString_Returns_DoubleValue() {
        let dbl = "20.369" as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseDouble(dbl), 20.369)
    }
    
    func test_ParseDouble_WhenNotDouble_Returns_DoubleValue() {
        let dbl = 452 as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseDouble(dbl), 452)
    }
    
    func test_Stract_When_KeyNot_Found_Returns_Nil() {
        let dict = ["key_1": 1 as AnyObject]
        
        let dictFound = JSONParserHelper.shared.stract(fromDict: dict, "foo")
        
        XCTAssertNil(dictFound)
    }
    
    func test_Stract_When_KeyFound_Returns_Dictionary() {
        let dict = ["key_1": ["key": 45 as AnyObject] as AnyObject]
        
        let dictFound = JSONParserHelper.shared.stract(fromDict: dict, "key_1")
        
        XCTAssertNotNil(dictFound)
    }
    
}
