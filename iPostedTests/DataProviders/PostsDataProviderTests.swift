//
//  PostsDataProviderTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class PostsDataProviderTests: XCTestCase {
    
    var sut: PostsDataProvider!
    var tableView: UITableView!
    var viewController: PostsViewController!
    
    override func setUp() {
        super.setUp()
        sut = PostsDataProvider()
        sut.posts = [Post]()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        
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
    
    func test_NumberOf_Rows_In_Section_IsEqual_PostsCount() {
        
        sut.posts?.append(buildPost())
        
        var numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        sut.posts?.append(buildPost())
        tableView.reloadData()
        
        numberOfRows = tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfRows, 2)
    }
    
    func test_CellForRow_Returns_PostsCell() {
        
        sut.posts?.append(buildPost())
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is PostCell)
    }
    
    func test_CellForRow_DequeuesCell_FromTableView() {
        
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockPostCell.self, forCellReuseIdentifier: "PostCell")
        
        sut.posts?.append(buildPost())
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_CellForRow_Calls_ConfigCell() {
        let mockTableView = MockTableView()
        mockTableView.dataSource = sut
        mockTableView.register(MockPostCell.self, forCellReuseIdentifier: "PostCell")
        
        let post = buildPost()
        sut.posts?.append(post)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockPostCell
        
        XCTAssertEqual(cell.configCellCalledOnce, 1)
    }
    
    // MARK: - Helpers
    
    func buildPost() -> Post {
        return Post(userId: 1, id: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }
    
}

extension PostsDataProviderTests {
    
    class MockTableView : UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
    }
    
    class MockPostCell : PostCell {
        var configCellCalledOnce = 0
        
        override func configCell(with post: Post) {
            configCellCalledOnce += 1
        }
    }
}
