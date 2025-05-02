//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Mariana Alexandre Dos Santos on 10/04/2025.
//

import XCTest
import Foundation
@testable import ComicsApp

final class MarvelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCharacterModelParser() throws {
        if let jsonURL = Bundle.main.url(forResource: "mockData", withExtension: "json") {
                let jsonData = try Data(contentsOf: jsonURL)
                let decoder = JSONDecoder()
            
                let characterData = try decoder.decode(APIResponse.self, from: jsonData)
            
                if let character = characterData.data.results.first {
                    XCTAssertEqual(character.name, "3-D Man", "Nome do personagem está incorreto")
                } else {
                    XCTFail("Nenhum personagem foi encontrado")
                }
            } else {
                XCTFail("Arquivo JSON não foi encontrado")
            }
    }
    
    func testCharacterCount() throws {
        if let jsonURL = Bundle.main.url(forResource: "mockData", withExtension: "json") {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            let characterData = try decoder.decode(APIResponse.self, from: jsonData)
            
            XCTAssertEqual(characterData.data.results.count, 1, "número incorreto de personagens")
        } else {
            XCTFail("Arquivo JSON não foi encontrado")
        }
    }
    
    func testCharacterNamePresence() throws {
        if let jsonURL = Bundle.main.url(forResource: "mockData", withExtension: "json") {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            let characterData = try decoder.decode(APIResponse.self, from: jsonData)
            
            if let character = characterData.data.results.first {
                XCTAssertNotNil(character.name, "O nome do personagem não está presente") //verificar se no nome nao é nil
                XCTAssertEqual(character.name, "3-D Man", "O nome do personagem está incorreto")
            } else {
                XCTFail("Nenhum personagem encontrado")
            }
        } else {
            XCTFail("Arquivo JSON não foi encontrado")
        }
    }
    
            
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
