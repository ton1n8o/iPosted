//
//  UserCellTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class UserCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: UserCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        
        _ = viewController.view
        
        tableView = viewController.tableView
        tableView?.dataSource = dataSource
        
        let indexPath = IndexPath(row: 0, section: 0)
        cell = tableView?
            .dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Has_Name_Label() {
        XCTAssertNotNil(cell.nameLabel)
    }
    
    func test_Has_UserName_Label() {
        XCTAssertNotNil(cell.userNameLabel)
    }
    
    func test_Has_Email_Label() {
        XCTAssertNotNil(cell.emailLabel)
    }
    
    func test_Has_Address_Label() {
        XCTAssertNotNil(cell.addressLabel)
    }
    
    func test_ConfigCell_SetLabelTexts() {
        let user = buildUser()
        
        cell.configCell(with: user)
        
        XCTAssertEqual(cell.nameLabel.text, "Leanne Graham")
        XCTAssertEqual(cell.userNameLabel.text, "Bret")
        XCTAssertEqual(cell.emailLabel.text, "Sincere@april.biz")
        XCTAssertEqual(cell.addressLabel.text, user.address?.description)
    }
    
    func test_ConfigCell_When_NoAddress_SetLabelTexts() {
        let user = User(
            id: 1,
            name: "Leanne Graham",
            userName: "Bret",
            email: "Sincere@april.biz",
            address: nil,
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: nil
        )
        
        cell.configCell(with: user)
        
        XCTAssertEqual(cell.nameLabel.text, "Leanne Graham")
        XCTAssertEqual(cell.userNameLabel.text, "Bret")
        XCTAssertEqual(cell.emailLabel.text, "Sincere@april.biz")
        XCTAssertEqual(cell.addressLabel.text, "--")
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

extension UserCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
