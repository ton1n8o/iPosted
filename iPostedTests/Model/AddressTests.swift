//
//  AddressTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class AddressTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_Sets_All_Properties_Properly() {
        
        guard let dictAddress = JSONMockLoader.loadJSONFrom(fileWithName: "address", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let address = Address(dict: dictAddress)
        let geo = Geo(lat: -37.3159, lng: 81.1496)
        
        XCTAssertEqual(address.street, "Kulas Light")
        XCTAssertEqual(address.suite, "Apt. 556")
        XCTAssertEqual(address.city, "Gwenborough")
        XCTAssertEqual(address.zipcode, "92998-3874")
        XCTAssertEqual(address.geo, geo)
    }
    
}
