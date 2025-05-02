//
//  Pokemon.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

struct Types: Codable {
    let slot : Int
    let type : type
}

struct type: Codable{
    let name : String
    let url : String
}

struct species: Codable{
    let name : String
    let url : String
}

struct OfficialArtwork: Codable{
    let front_default : String
    let front_shiny : String
}

struct Showdown: Codable{
    let front_default : String
}

struct OtherSprites: Codable{
    let officialArtwork : OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct Sprites: Codable{
    let front_default : String
    let front_shiny : String
    let other : OtherSprites
}

struct Ability: Codable{
    let name : String
    let url : String
}

struct Abilities: Codable{
    let ability : Ability
    let is_hidden : Bool
    let slot : Int
}

struct Stat: Codable{
    let name : String
    let url : String
}

struct Stats: Codable {
    let base_stat : Int
    let stat : Stat
}

struct Pokemon: Codable {
    let name : String
    let id : Int
    let species : species
    let types : [Types]
    let sprites : Sprites
    let abilities : [Abilities]
    let stats : [Stats]
    let height : Int
    let weight : Int
}
