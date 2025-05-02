//
//  CharacterTableCellViewModelTests.swift
//  ComicsAppTests
//
//  Created by Diogo Alexandre Pereira on 22/4/25.
//

import XCTest
@testable import ComicsApp

final class CharacterTableCellViewModelTests: XCTestCase {
    
    var sut : CharacterTableCellViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = CharacterTableCellViewModel(character: Character(id: 0,
                                                               name: "Test Character" ,
                                                               status: .alive,species: "Human", type: "Human",
                                                               gender: .male, origin: .init(name: "Test Origin", url: ""),
                                                               location: .init(name: "Test Location", url: ""),
                                                               image: "" ,
                                                               episode: ["1","2"],url: "",created: ""))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
     func testMakeImageURLSucess() throws{
        //        Given
        let expectedImageURL = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        
        let character = Character(id: 1,
                                  name: "Test Character" ,
                                  status: .alive,species: "Human", type: "Human",
                                  gender: .male, origin: .init(name: "Test Origin", url: ""),
                                  location: .init(name: "Test Location", url: ""),
                                  image: expectedImageURL,
                                  episode: ["1","2"],url: "",created: "")
        
        //        When
        let result = character.image
        
        //        Then
         XCTAssertEqual(result, expectedImageURL)
    }
    
     func testMakeImageURLError() throws {
        //        Given
        let expectedImageURL = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        
        let character = Character(id: 1,
                                  name: "Test Character" ,
                                  status: .alive,species: "Human", type: "Human",
                                  gender: .male, origin: .init(name: "Test Origin", url: ""),
                                  location: .init(name: "Test Location", url: ""),
                                  image: "",
                                  episode: ["1","2"],url: "",created: "")
        
        //        When
        let result = character.image
        
        //        Then
        XCTAssertNotEqual(result, expectedImageURL)
    }
    
     func testStautsColorGreen(){
//         Given
         let status = sut.status
//         When
        let result = sut.stautsColor(status: status)
        
//         Then
        XCTAssertEqual(result, .systemGreen)
        
    }
    
    func testStautsColorRed(){
//         Given
        sut.status = .dead
        let status = sut.status
        
//         When
       let result = sut.stautsColor(status: status)
       
//         Then
       XCTAssertEqual(result, .systemRed)
       
   }
    
    func testStautsColorGray(){
//         Given
        sut.status = .unknown
        let status = sut.status
        
//         When
       let result = sut.stautsColor(status: status)
       
//         Then
       XCTAssertEqual(result, .systemGray)
       
   }
    
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//     }
//    }
    
}
