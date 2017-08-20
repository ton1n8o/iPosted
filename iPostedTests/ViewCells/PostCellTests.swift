//
//  PostCellTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class PostCellTests: XCTestCase {
    
    var tableView: UITableView!
    let dataSource = FakeDataSource()
    var cell: PostCell!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        
        _ = viewController.view
        
        tableView = viewController.tableView
        tableView?.dataSource = dataSource
        
        let indexPath = IndexPath(row: 0, section: 0)
        cell = tableView?
            .dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Has_Title_Label() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func test_Has_Body_Label() {
        XCTAssertNotNil(cell.bodyLabel)
    }
    
    func test_ConfigCell_SetLabelTexts() {
        let post = Post(userId: 1, id: 1, title: "title x", body: "body y")
        
        cell.configCell(with: post)
        
        XCTAssertEqual(cell.titleLabel.text, "title x")
        XCTAssertEqual(cell.bodyLabel.text, "body y")
    }
    
}

extension PostCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
