//
//  PokemonSpecies.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

struct color: Codable {
    let name : String
    let url : String
}

struct evolves_from_species: Codable {
    let name : String
    let url : String
}

struct evolution_chain : Codable{
    let url : String
}

struct PokemonSpecies: Codable {
    var evolves_from_species : evolves_from_species?
    let evolution_chain : evolution_chain?
    let color : color
    let name : String
    let id : Int
    let species : species
}
