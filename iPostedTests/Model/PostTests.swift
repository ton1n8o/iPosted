//
//  PostTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 20/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class PostTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_Init_WithDictionary_Sets_All_Properties() {
        
        guard let dictPost = JSONMockLoader.loadJSONFrom(file: "post", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let user = Post(dict: dictPost)
        
        XCTAssertEqual(user.userId, 1)
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(user.body, "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto")
    }
    
    func test_Init_Sets_All_Properties_Properly() {
        
        let post = Post(
            userId: 1,
            id: 10,
            title: "Foo title",
            body: "Bar body"
        )
        
        XCTAssertEqual(post.userId, 1)
        XCTAssertEqual(post.id, 10)
        XCTAssertEqual(post.title, "Foo title")
        XCTAssertEqual(post.body, "Bar body")
        
    }
    
    // MARK: - Equatable tests
    
    func test_When_UserId_Differ_ShouldNot_Be_Equal() {
        let postA = Post(userId: 1, id: 1, title: "", body: "")
        let postB = Post(userId: 2, id: 1, title: "", body: "")
        
        XCTAssertNotEqual(postA, postB)
    }
    
    func test_When_Id_Differ_ShouldNot_Be_Equal() {
        let postA = Post(userId: 1, id: 1, title: "", body: "")
        let postB = Post(userId: 1, id: 2, title: "", body: "")
        
        XCTAssertNotEqual(postA, postB)
    }
    
    func test_When_Title_Differ_ShouldNot_Be_Equal() {
        let postA = Post(userId: 1, id: 1, title: "Foo title", body: "")
        let postB = Post(userId: 1, id: 1, title: "No foo", body: "")
        
        XCTAssertNotEqual(postA, postB)
    }
    
    func test_When_Body_Differ_ShouldNot_Be_Equal() {
        let postA = Post(userId: 1, id: 1, title: "", body: "my body")
        let postB = Post(userId: 1, id: 1, title: "", body: "your body")
        
        XCTAssertNotEqual(postA, postB)
    }
    
    func test_When_Equal_Should_Be_Equal() {
        let postA = Post(userId: 1, id: 1, title: "", body: "my body")
        let postB = Post(userId: 1, id: 1, title: "", body: "my body")
        
        XCTAssertEqual(postA, postB)
    }
    
}
