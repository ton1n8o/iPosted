//
//  UsersViewControllerTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class UsersViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_TableView_isNotNill_After_ViewDidLoad() {
        let sut = UsersViewController()
        
        _ = sut.view
        
        XCTAssertNotNil(sut.tableView)
    }
    
}
