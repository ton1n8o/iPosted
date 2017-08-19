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
    
    var sut: UsersViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController")
        
        sut = viewController as! UsersViewController
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_TableView_isNotNill_After_ViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_Sets_TableViewDataSource() {
        XCTAssertTrue(sut.tableView?.dataSource is UsersDataProvider)
    }
    
    func test_LoadingView_Sets_TableViewDelegate() {
        XCTAssertTrue(sut.tableView?.delegate is UsersDataProvider)
    }
    
    func test_LoadingView_Sets_DataSource_And_Delegate_To_SameObject() {
        XCTAssertEqual(sut.tableView?.dataSource as? UsersDataProvider,
                       sut.tableView?.delegate as? UsersDataProvider)
    }
    
    
}
