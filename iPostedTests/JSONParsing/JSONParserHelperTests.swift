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
    
    func test_ParseString_Returns_StringValue() {
        let str = "Hello" as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseString(str), "Hello")
    }
    
    func test_ParseString_WhenNotString_Returns_EmptyString() {
        let str = 85.7 as AnyObject
        XCTAssertEqual(JSONParserHelper.shared.parseString(str), "")
    }

    
}
