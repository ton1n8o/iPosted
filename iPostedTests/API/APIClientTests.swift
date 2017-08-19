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
    
    func test_apiClient_Uses_Proper_EndPoint() {
        let sut = APIClient()
        let mockURLSession = MockURLSession()
        sut.session = mockURLSession
        
        let completion = { (users: [User]?, error: Error?) in }
        
        sut.loadUsers(completion: completion)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        XCTAssertEqual(urlComponents?.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(urlComponents?.path, "/users")
        
    }
    
}

extension APIClientTests {
    class MockURLSession: SessionProtocol {
        var url: URL?
        func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
