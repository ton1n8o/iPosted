//
//  CompanyTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class CompanyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_WithDictionary_All_Properties_Properly() {
        
        guard let dictCompany = JSONMockLoader.loadJSONFrom(fileWithName: "company", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let company = Company(dict: dictCompany)
        
        XCTAssertEqual(company.name, "Romaguera-Crona")
        XCTAssertEqual(company.catchPhrase, "Multi-layered client-server neural-net")
        XCTAssertEqual(company.bs, "harness real-time e-markets")
    }
    
    func test_Init_Sets_All_Properties_Properly() {
        let company = Company(
            name: "Foo Name",
            catchPhrase: "CatchPhrase Foo",
            bs: "my bs"
        )
        
        XCTAssertEqual(company.name, "Foo Name")
        XCTAssertEqual(company.catchPhrase, "CatchPhrase Foo")
        XCTAssertEqual(company.bs, "my bs")
    }
    
}
