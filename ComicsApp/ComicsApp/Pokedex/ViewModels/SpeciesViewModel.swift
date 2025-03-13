//
//  structPokemons.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.
//

import Foundation

class SpeciesViewModel {
    var pokemon : String
    var url : String
    var shiny : Bool = false
    
    var id : Int {
        get{
            return Int(url.split(separator: "/").last!)!
        }
    }
    
    var listInfo : String{
        get {
            return "\(pokemon.split(separator: "-").joined(separator: " ").capitalized)"
        }
    }
    
    var imagerURL: URL {
        get {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + String(id) + ".png")!
            
            //            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/" + String(id) + ".gif")!
        }
    }
    
    var imageURL: URL {
        get {
            let random = Int.random(in: 1...25)
            var shinystring = ""
            if (random == 5){
                shinystring = "shiny/"
                shiny = true
            }
            
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + shinystring + String(id) + ".png")!
        }
    }
    
    init (_ results: results){
        self.pokemon = results.name
        self.url = results.url
        
    }
    
}
