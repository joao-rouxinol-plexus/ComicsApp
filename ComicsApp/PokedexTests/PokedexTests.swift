//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Duarte Miguel Charrua Silva on 10/04/2025.
//

import XCTest
import Foundation
@testable import ComicsApp
final class PokedexTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    func testPokemonModelParser() throws {
        if let jsonURL = Bundle.main.url(forResource: "PokemonUnitTestAPIResponse", withExtension: "json"){
            let jsonData = try Data(contentsOf: jsonURL)
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
                XCTAssertEqual(pokemon.name, "nidorina", "Nome do pokemon incorreto")
                XCTAssertEqual(pokemon.height, 8, "Altura do pokemon incorreta")
                
            }
        }
        else {
            XCTFail("Arquivo JSON não encontrado")
        }
    }
    
    func testPokemonViewModelParser() throws {
        if let jsonURL = Bundle.main.url(forResource: "PokemonUnitTestAPIResponse", withExtension: "json"){
            let jsonData = try Data(contentsOf: jsonURL)
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: jsonData)
                let pokemonViewModel = PokemonViewModel(pokemon: pokemon)
                
                XCTAssertEqual(pokemonViewModel.name, "Nidorina", "Nome do pokemon incorreto na viewModel")
                XCTAssertEqual(pokemonViewModel.height, 80, "Altura do pokemon incorreta na viewModel")
            }
        }
        else {
            XCTFail("Arquivo JSON não encontrado")
        }
    }
    
    func testPokemonListParser() throws {
        if let jsonURL = Bundle.main.url(forResource: "PokemonListingUnitTestAPIResponse", withExtension: "json"){
            let jsonData = try Data(contentsOf: jsonURL)
            do {
                let decoder = JSONDecoder()
                let pokemonList = try decoder.decode(PokemonList.self, from: jsonData)
                XCTAssertEqual(pokemonList.count, 1302, "Número de Pokémon incorreto")
                XCTAssertEqual(pokemonList.next, "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20", "Altura do pokemon incorreta")
            }
        }
        else {
            XCTFail("Arquivo JSON não encontrado")
        }
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
