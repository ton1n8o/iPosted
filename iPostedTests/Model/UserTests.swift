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
    
    func test_Init_WithDictionary_Sets_All_Properties() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(file: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        guard let dictAddress = JSONMockLoader.loadJSONFrom(file: "address", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        guard let dictCompany = JSONMockLoader.loadJSONFrom(file: "company", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = User(dict: dictUser)
        let address = Address(dict: dictAddress)
        let company = Company(dict: dictCompany)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.address, address)
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.website, "hildegard.org")
        XCTAssertEqual(user.company, company)
    }
    
    func test_Init_WithDictionary_NoAddress_Sets_All_Properties_But_Address() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(file: "user_no_address", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        guard let dictCompany = JSONMockLoader.loadJSONFrom(file: "company", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = User(dict: dictUser)
        let company = Company(dict: dictCompany)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertNil(user.address)
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.website, "hildegard.org")
        XCTAssertEqual(user.company, company)
    }
    
    func test_Init_WithDictionary_NoCompany_Sets_All_Properties_But_Company() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(file: "user_no_company", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = User(dict: dictUser)
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertNotNil(user.address)
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.website, "hildegard.org")
        XCTAssertNil(user.company)
    }
    
}
