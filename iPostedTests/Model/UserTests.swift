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
    
    func test_Init_Sets_All_Properties_Properly() {
        
        guard let dictAddress = JSONMockLoader.loadJSONFrom(file: "address", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        guard let dictCompany = JSONMockLoader.loadJSONFrom(file: "company", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let address = Address(dict: dictAddress)
        let company = Company(dict: dictCompany)
        
        let user = User(
            id: 1,
            name: "Leanne Graham",
            userName: "Bret",
            email: "Sincere@april.biz",
            address: address,
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: company
        )
        
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.userName, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
        XCTAssertEqual(user.address, address)
        XCTAssertEqual(user.phone, "1-770-736-8031 x56442")
        XCTAssertEqual(user.website, "hildegard.org")
        XCTAssertEqual(user.company, company)
    }
    
    // MARK: - Equatable tests
    
    func test_When_Id_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "Foo", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 2, name: "Foo", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Name_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "Foo", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 1, name: "Noo", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_UserName_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "", userName: "Foo", email: "",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 1, name: "", userName: "Bar", email: "",
                         address: nil, phone: "", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Email_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "", userName: "", email: "my@com.me",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 1, name: "", userName: "", email: "my@com",
                         address: nil, phone: "", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Address_Differ_ShouldNot_Be_Equal() {
        
        let address = Address.init(street: "", suite: "", city: "", zipcode: "", geo: nil)
        
        let userA = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 1, name: "", userName: "", email: "",
                         address: address, phone: "", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Phone_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "321-52", website: "", company: nil)
        let userB = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "123", website: "", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Website_Differ_ShouldNot_Be_Equal() {
        let userA = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "", website: "wwww.com", company: nil)
        let userB = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "", website: ".com", company: nil)
        
        XCTAssertNotEqual(userA, userB)
    }
    
    func test_When_Company_Differ_ShouldNot_Be_Equal() {
        
        let company = Company(name: "", catchPhrase: "", bs: "")
        
        let userA = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "", website: "", company: nil)
        let userB = User(id: 1, name: "", userName: "", email: "",
                         address: nil, phone: "", website: "", company: company)
        
        XCTAssertNotEqual(userA, userB)
    }
    
}
