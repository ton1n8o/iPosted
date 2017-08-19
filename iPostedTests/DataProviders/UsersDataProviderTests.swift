//
//  UsersDataProviderTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class UsersDataProviderTests: XCTestCase {
    
    var sut: UsersDataProvider!
    var tableView: UITableView!
    var viewController: UsersViewController!
    
    override func setUp() {
        super.setUp()
        sut = UsersDataProvider()
        sut.users = [User]()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        
        _ = viewController.view
        
        tableView = viewController.tableView
        tableView.dataSource = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_NumberOf_Sections_isOne() {
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func test_NumberOf_Rows_In_Section_IsEqual_UsersCount() {
        guard let dictUserA = JSONMockLoader.loadJSONFrom(file: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        guard let dictUserB = JSONMockLoader.loadJSONFrom(file: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        sut.users?.append(User(dict: dictUserA))
        
        var numberOfSections = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfSections, 1)
        
        sut.users?.append(User(dict: dictUserB))
        tableView.reloadData()
        
        numberOfSections = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_CellForRow_Returns_UsersCell() {
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(file: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        sut.users?.append(User(dict: dictUser))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        
        XCTAssertTrue(cell is UserCell)
    }
    
    func test_CellForRow_DequeuesCell_FromTableView() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        
        guard let dictUser = JSONMockLoader.loadJSONFrom(file: "user", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        sut.users?.append(User(dict: dictUser))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
}

extension UsersDataProviderTests {
    
    class  MockTableView : UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}
