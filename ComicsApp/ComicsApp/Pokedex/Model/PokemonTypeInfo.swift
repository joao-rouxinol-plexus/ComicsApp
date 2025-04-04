//
//  Pokemon.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

struct swordShield: Codable {
    let name_icon : String
}

struct generationviiiTypeSprites: Codable {
    let sword_shield : swordShield
    
}

struct TypeSprites: Codable {
    let generationViii : generationviiiTypeSprites
    
    enum CodingKeys: String, CodingKey {
        case generationViii = "generation-viii"
    }
}

struct PokemonTypeInfo: Codable {
    let id : Int
    let name : String
    let sprites: TypeSprites
    
}
