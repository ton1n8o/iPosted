//
//  GeoTestes.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class GeoTestes: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_WithDictionary_Sets_All_Properties_Properly() {
        
        guard let dictGeo = JSONMockLoader.loadJSONFrom(fileWithName: "geo", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let geo = Geo(dict: dictGeo)
        
        XCTAssertEqual(geo.lat, -37.3159)
        XCTAssertEqual(geo.lng, 81.1496)
        
    }
    
    func test_Init_Sets_All_Properties_Properly() {
        
        let geo = Geo(lat: -37.3125, lng: 81.5496)
        
        XCTAssertEqual(geo.lat, -37.3125)
        XCTAssertEqual(geo.lng, 81.5496)
        
    }
    
    // MARK: - Equatable tests
    
    func test_When_Lat_Differ_ShouldNot_Be_Equal() {
        let geoA = Geo(lat: 35.23626, lng: 81.26955)
        let geoB = Geo(lat: 36.23626, lng: 81.26955)
        
        XCTAssertNotEqual(geoA, geoB)
    }
    
    func test_When_Lng_Differ_ShouldNot_Be_Equal() {
        let geoA = Geo(lat: 35.23626, lng: 81.26955)
        let geoB = Geo(lat: 35.23626, lng: 85.26955)
        
        XCTAssertNotEqual(geoA, geoB)
    }
}
