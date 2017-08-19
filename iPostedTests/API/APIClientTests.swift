//
//  APIClientTests.swift
//  iPostedTests
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class APIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Endpoints tests
    
    func test_ApiClient_LoadUser_Should_Use_Proper_Endpoint() {
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let completion = { (users: [User]?, error: Error?) in }
        
        sut.loadUsers(completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail("URL not provided to the dataTask() method")
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(urlComponents?.path, "/users")
        
    }
    
    func test_ApiClient_LoadPosts_Should_Use_Proper_Endpoint() {
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let completion = { (users: [Post]?, error: Error?) in }
        
        let userId = 1
        sut.loadPosts(userId: userId, completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail("URL not provided to the dataTask() method")
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let qiUserId = URLQueryItem(name: "userId", value: "\(userId)")
        
        XCTAssertEqual(urlComponents?.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(urlComponents?.path, "/posts")
        XCTAssertTrue(urlComponents?.queryItems?.contains(qiUserId) ?? false, "the URL must contain userId property.")
        
    }
    
    // MARK: - LoadUser endpoint tests
    
    func test_LoadUsers_WhenSuccessfull_Returns_Users() {
        
        guard let jsonData = JSONMockLoader.loadJSONData(file: "users_array", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        
        sut.session = mockURLSession
        
        let usersExpectation = expectation(description: "Users")
        
        var users: [User]? = nil
        
        sut.loadUsers { (usersFetched, error) in
            users = usersFetched
            usersExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(users?.count, 2)
        }
    }
    
    func test_LoadUsers_WhenJSONInvalid_Returns_Error() {
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadUsers { (usersFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    func test_LoadUsers_WhenJSON_NotCompatible_Returns_Error() {
        
        let sut = APIClient()
        let jsonData = "{\"userName\": \"Jhon Doo\"}".data(using: .utf8)
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadUsers { (usersFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    func test_LoadUsers_WhenDataIs_Nil_Returns_Error() {
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadUsers { (usersFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    func test_LoadUsers_WhenResponseHas_Error_Returns_Error() {
        
        guard let jsonData = JSONMockLoader.loadJSONData(file: "users_array", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let sut = APIClient()
        let error = NSError(domain: "An Error", code: 123, userInfo: nil)
        
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: error)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadUsers { (usersFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    // MARK: - Posts endpoint tests
    
    func test_LoadPosts_WhenSuccessfull_Returns_Posts() {
        
        guard let jsonData = JSONMockLoader.loadJSONData(file: "posts_array", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        
        sut.session = mockURLSession
        
        let postsExpectation = expectation(description: "Posts")
        
        var posts: [Post]? = nil
        
        sut.loadPosts(userId: 1, completion: { (postsFetched, error) in
            posts = postsFetched
            postsExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertEqual(posts?.count, 2)
        }
    }
    
    func test_LoadPosts_WhenJSONInvalid_Returns_Error() {
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: Data(), urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let postsExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadPosts(userId: 1, completion: { (postsFetched, error) in
            catchedError = error
            postsExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    func test_LoadPosts_WhenJSON_NotCompatible_Returns_Error() {
        
        let sut = APIClient()
        let jsonData = "{\"userName\": \"Jhon\"}".data(using: .utf8)
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadPosts(userId: 1, completion: { (postsFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
    func test_LoadPosts_WhenDataIs_Nil_Returns_Error() {
        
        let sut = APIClient()
        let mockURLSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadPosts(userId: 1, completion: { (postsFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
    }
    
    func test_LoadPosts_WhenResponseHas_Error_Returns_Error() {
        
        guard let jsonData = JSONMockLoader.loadJSONData(file: "posts_array", usingClass: self) else {
            XCTFail("a valid JSON file is needed to proceed with the test.")
            return
        }
        
        let sut = APIClient()
        let error = NSError(domain: "An Error", code: 123, userInfo: nil)
        
        let mockURLSession = MockURLSession(data: jsonData, urlResponse: nil, error: error)
        sut.session = mockURLSession
        
        let errorExpectation = expectation(description: "Error")
        
        var catchedError: Error? = nil
        
        sut.loadPosts(userId: 1, completion: { (postsFetched, error) in
            catchedError = error
            errorExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(catchedError)
        }
        
    }
    
}

extension APIClientTests {
    
    class MockURLSession: SessionProtocol {
        var url: URL?
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(self.data, self.urlResponse, self.responseError)
            }
        }
    }
}
