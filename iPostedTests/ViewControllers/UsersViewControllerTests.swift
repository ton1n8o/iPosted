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
    
    func Xtest_ReloadData_Must_Be_Called_Once_ViewDidLoad() {
        let tableView = MockTableView()
        sut.tableView = tableView
        sut.apiClient = MockAPIClient()
        sut.viewDidLoad()
        
        XCTAssertEqual(tableView.realodDataGotCalled, 1)
    }
    
    func test_User_Selected_Show_UserPosts_ViewController() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        sut.dataProvider.delegate = sut
        sut.dataProvider.users = [buildUser()]
        sut.tableView?.reloadData()
        
        _ = sut.view
        
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView?.delegate?.tableView!(sut.tableView!, didSelectRowAt: indexPath)
        
        guard let postsViewController = mockNavigationController.pushedViewController as? PostsViewController else {
            XCTFail("once a user is selected, PostsViewController must be presented"); return
        }
        
        guard let userSelected = postsViewController.user else {
            XCTFail("a user must be sent to the PostViewController once selected"); return
        }
        
        _ = postsViewController.view
        
        XCTAssertEqual(postsViewController.user, userSelected)
    }
    
    func test_DidSelectUserDelegate_Must_Be_Set_OnceViewDidLoad() {
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertNotNil(sut.dataProvider.delegate)
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

extension UsersViewControllerTests {
    
    class MockTableView: UITableView {
        
        var realodDataGotCalled = 0
        
        // with this it is possible to know that the reload happened.
        var onReload: (() -> Void)? = nil
        
        override func reloadData() {
            realodDataGotCalled += 1
            onReload?()
        }
        
    }
    
    class MockAPIClient : APIClient {
        var loadUserGotCalledOnce = 0
        var errorResponse: Error?
        var usersResponse: [User]? = nil
        override func loadUsers(completion: @escaping ([User]?, Error?) -> Void) {
            loadUserGotCalledOnce += 1
            completion(usersResponse, errorResponse)
        }
    }
    
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }

}
