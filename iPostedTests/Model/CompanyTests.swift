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
        
        guard let dictCompany = JSONMockLoader.loadJSONFrom(file: "company", usingClass: self) else {
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
    
    // MARK: - Equatable tests
    
    func test_When_Name_Differ_ShouldNot_Be_Equal() {
        let companyA = Company(name: "Foo", catchPhrase: "", bs: "")
        let companyB = Company(name: "Boo", catchPhrase: "", bs: "")
        
        XCTAssertNotEqual(companyA, companyB)
    }
    
    func test_When_CatchPhrase_Differ_ShouldNot_Be_Equal() {
        let companyA = Company(name: "", catchPhrase: "Foo", bs: "")
        let companyB = Company(name: "", catchPhrase: "Bar", bs: "")
        
        XCTAssertNotEqual(companyA, companyB)
    }
    
    func test_When_Bs_Differ_ShouldNot_Be_Equal() {
        let companyA = Company(name: "", catchPhrase: "", bs: "Foo")
        let companyB = Company(name: "", catchPhrase: "", bs: "Bar")
        
        XCTAssertNotEqual(companyA, companyB)
    }
    
}
