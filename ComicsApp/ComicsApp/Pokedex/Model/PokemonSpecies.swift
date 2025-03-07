//
//  Quote.swift
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
    
    var imageURL: URL {
        get {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + String(id) + ".png")!
        }
    }
    
    var gifURL: URL {
        get {
            let random = Int.random(in: 1...5)
            var shinystring = ""
            if (random == 5){
                shinystring = "shiny/" }
            
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/" + shinystring + String(id) + ".gif")!
        }
    }
    
    var oldimageURL: URL {
        get {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + String(id) + ".png")!
        }
    }
}


