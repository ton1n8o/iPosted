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
        
        sut.users?.append(buildUser())
        
        var numberOfSections = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfSections, 1)
        
        sut.users?.append(buildUser())
        tableView.reloadData()
        
        numberOfSections = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func test_CellForRow_Returns_UsersCell() {
        
        sut.users?.append(buildUser())
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        
        XCTAssertTrue(cell is UserCell)
    }
    
    func test_CellForRow_DequeuesCell_FromTableView() {
        
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockUserCell.self, forCellReuseIdentifier: "UserCell")
        
        sut.users?.append(buildUser())
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_CellForRow_Calls_ConfigCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockUserCell.self, forCellReuseIdentifier: "UserCell")
        
        let user = buildUser()
        sut.users?.append(user)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockUserCell
        
        XCTAssertEqual(cell.catcheUser, user)
    }
    
    // MARK: - Helpers
    
    func buildUser() -> User {
        
        let address = Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: Geo(lat: -37.3159, lng: 81.1496)
        )
        let company = Company(
            name: "Romaguera-Crona",
            catchPhrase: "Multi-layered client-server neural-net",
            bs: "harness real-time e-markets"
        )
        
        return User(
            id: 1,
            name: "Leanne Graham",
            userName: "Bret",
            email: "Sincere@april.biz",
            address: address,
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: company
        )
        
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
    
    class MockUserCell : UserCell {
        var catcheUser: User?
        
        override func configCell(with user: User) {
            catcheUser = user
        }
    }
}
