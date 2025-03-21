//
//  PokemonSpeciesList.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

struct results: Codable {
    let name : String
    let url : String
}

struct PokemonSpeciesList: Codable {
    let count : Int
    var next : String?
    var previous : String?
    var results : [results]
}


