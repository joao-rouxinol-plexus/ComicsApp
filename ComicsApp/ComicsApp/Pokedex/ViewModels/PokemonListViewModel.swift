//
//  PokemonListViewModel.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.
//

import Foundation
let pokemonMainViewModel = PokemonMainViewModel()

class PokemonListViewModel {
    var pokemon : String
    var url : String
    var shiny : Bool = false
    var types : [types]
    var id : Int
    
    var formattedID : String{
        get {
            return String(format: "#%03d", id)
        }
    }
    
    
    var type1 : String{
        get {
            return types[0].type.name
        }
    }
    var type2 : String{
        get {
            if types.count < 2 {
                return ""
            }
            return types[1].type.name
        }
    }
    
    var listInfo : String{
        get {
            return "\(pokemon.split(separator: "-").joined(separator: " ").capitalized)"
        }
    }
    
    
    
    
    init (_ listResult: PokemonViewModel ){
        self.pokemon = listResult.name
        self.id = listResult.id
        self.types = listResult.types
        self.url = PokemonNetworkConstants().speciesURL + String(listResult.id)
        self.shiny = listResult.shiny
    }
    
}




//MARK - Imagens
extension PokemonListViewModel {
    
    var imagerURL: URL {
        get {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + String(id) + ".png")!
            
            //            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/" + String(id) + ".gif")!
        }
    }
    
    var imageURL: URL {
        get {
            var shinystring = ""
            if (shiny == true){
                shinystring = "shiny/"
            }
            
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/" + shinystring + String(id) + ".png")!
        }
    }
}
