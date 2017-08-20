//
//  PostsViewControllerTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class PostsViewControllerTests: XCTestCase {
    
    var sut: PostsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PostsViewController")
        
        sut = viewController as! PostsViewController
        _ = sut.view
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_TableView_isNotNill_After_ViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_LoadingView_Sets_TableViewDataSource() {
        XCTAssertTrue(sut.tableView?.dataSource is PostsDataProvider)
    }
    
    func test_LoadingView_Sets_TableViewDelegate() {
        XCTAssertTrue(sut.tableView?.delegate is PostsDataProvider)
    }
    
    func test_APIClient_LoadUsersPost_Must_Be_Called_Once_ViewWillAppear() {
        let mockAPI = MockAPIClient()
        sut.apiClient = mockAPI
        sut.user = buildUser(withId: 5)
        
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(mockAPI.loadUserPostsGotCalledOnce, 1)
        XCTAssertEqual(mockAPI.userIdToLoadPosts, sut.user?.id)
    }
    
    func test_ReloadData_Must_Be_Called_Once_LoadPosts_RequestFinish() {
        let mockAPI = MockAPIClient()
        let mockTableView = MockTableView()
        
        sut.tableView = mockTableView
        sut.apiClient = mockAPI
        sut.user = buildUser(withId: 3)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        let expectationTableViewReload = expectation(description: "the tableView did not execute reload on time.")
        
        mockTableView.onReload = {
            expectationTableViewReload.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(mockTableView.realodDataGotCalledOnce, 1)
        }
    }
    
    // MARK: - Helpers
    
    func buildUser(withId: Int) -> User {
        
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
            id: withId,
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

extension PostsViewControllerTests {
    
    class MockAPIClient : APIClient {
        
        var loadUserPostsGotCalledOnce = 0
        var userIdToLoadPosts = -1
        
        override func loadPosts(userId: Int, completion: @escaping ([Post]?, Error?) -> Void) {
            userIdToLoadPosts = userId
            loadUserPostsGotCalledOnce += 1
            completion(nil, nil)
        }
    }
    
    class MockTableView: UITableView {
        
        var realodDataGotCalledOnce = 0
        
        // with this it is possible to know that the reload happened.
        var onReload: (() -> Void)? = nil
        
        override func reloadData() {
            realodDataGotCalledOnce += 1
            onReload?()
        }
        
    }
    
}
