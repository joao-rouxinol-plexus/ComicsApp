//
//  RickMortyMainViewControllerTests.swift
//  ComicsAppTests
//
//  Created by Diogo Alexandre Pereira on 22/4/25.
//

import XCTest
@testable import ComicsApp

final class RickMortyMainViewControllerTests: XCTestCase {
    
    var sut : RickMortyMainViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = RickMortyMainViewController()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testConfigView() throws {
        
        //         Given
        let expectedTitle = "Characters"
        let expectedColor = UIColor.systemBackground
        
        //         When
        let title = sut.title
        let color = sut.view.backgroundColor
        
        //         Then
        XCTAssertEqual(expectedTitle, title)
        XCTAssertEqual(expectedColor, color)
    }
    
    
    }

