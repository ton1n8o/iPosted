//
//  StoryboardTests.swift
//  iPosted
//
//  Created by Antonio da Silva on 19/08/2017.
//  Copyright © 2017 TNTStudios. All rights reserved.
//

import XCTest
@testable import iPosted

class StoryboardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_InitialViewController_Is_UsersViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = storyboard.instantiateInitialViewController() as!
        UINavigationController
        
        let rootViewController = navigationController.viewControllers[0]
        
        XCTAssertTrue(rootViewController is UsersViewController)
    }
    
}
