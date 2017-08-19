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
    
    func test_Init_WithDictionary_Sets_All_Properties() {
        
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
    
    func test_Init_WithDictionary_NoGeo_Sets_All_Properties_But_Geo() {
        
        guard let dictAddress = JSONMockLoader.loadJSONFrom(fileWithName: "address_no_geo", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let address = Address(dict: dictAddress)
        
        XCTAssertEqual(address.street, "Kulas Light")
        XCTAssertEqual(address.suite, "Apt. 556")
        XCTAssertEqual(address.city, "Gwenborough")
        XCTAssertEqual(address.zipcode, "92998-3874")
        XCTAssertNil(address.geo)
        
    }
    
    func test_Init_Sets_All_Properties_Properly() {
        
        let address = Address(
            street: "Foo",
            suite: "Foo1",
            city: "CityFoo",
            zipcode: "ZipFoo",
            geo: Geo(lat: 1.10, lng: 2.20)
        )
        
        XCTAssertEqual(address.street, "Foo")
        XCTAssertEqual(address.suite, "Foo1")
        XCTAssertEqual(address.city, "CityFoo")
        XCTAssertEqual(address.zipcode, "ZipFoo")
        XCTAssertEqual(address.geo?.lat, 1.10)
        XCTAssertEqual(address.geo?.lng, 2.20)
        
    }
    
    // MARK: - Equatable tests
    
    func test_When_Street_Differ_ShouldNot_Be_Equal() {
        let addressA = Address(street: "Foo", suite: "", city: "", zipcode: "", geo: nil)
        let addressB = Address(street: "Bar", suite: "", city: "", zipcode: "", geo: nil)
        
        XCTAssertNotEqual(addressA, addressB)
    }
    
    func test_When_Suite_Differ_ShouldNot_Be_Equal() {
        let addressA = Address(street: "", suite: "Foo", city: "", zipcode: "", geo: nil)
        let addressB = Address(street: "", suite: "Bar", city: "", zipcode: "", geo: nil)
        
        XCTAssertNotEqual(addressA, addressB)
    }
    
    func test_When_City_Differ_ShouldNot_Be_Equal() {
        let addressA = Address(street: "", suite: "", city: "Foo", zipcode: "", geo: nil)
        let addressB = Address(street: "", suite: "", city: "Bar", zipcode: "", geo: nil)
        
        XCTAssertNotEqual(addressA, addressB)
    }
    
    func test_When_ZipCode_Differ_ShouldNot_Be_Equal() {
        let addressA = Address(street: "", suite: "", city: "", zipcode: "123", geo: nil)
        let addressB = Address(street: "", suite: "", city: "", zipcode: "321", geo: nil)
        
        XCTAssertNotEqual(addressA, addressB)
    }
    
    func test_When_Geo_Differ_ShouldNot_Be_Equal() {
        
        let addressA = Address(street: "", suite: "", city: "", zipcode: "",
                               geo: Geo(lat: 1.1, lng: 1.1))
        let addressB = Address(street: "", suite: "", city: "", zipcode: "",
                               geo: Geo(lat: 1.2, lng: 2.1))
        
        XCTAssertNotEqual(addressA, addressB)
    }
    
}
