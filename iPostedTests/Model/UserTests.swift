//
//  UserTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_WithDictionary_All_Properties_Properly() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(fileWithName: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = User(dict: dictUser)
        let address = Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: Geo(lat: -37.3159, lng: 81.1496)
        )
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.address, address)
        XCTAssertEqual(user.website, "hildegard.org") // TODO: company
    }
    
    func test_Init_WithDictionary_NoAddress_Sets_All_Properties_But_Address() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(fileWithName: "user_no_address", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = User(dict: dictUser)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertNil(user.address)
    }
    
}
