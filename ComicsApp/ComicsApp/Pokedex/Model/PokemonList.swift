//
//  PokemonList.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

struct PokemonList: Codable {
    let count : Int
    var next : String?
    var previous : String?
    var results : [results]
}
