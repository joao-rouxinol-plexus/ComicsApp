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
    var types : [Types]
    var id : Int
    var sprite : URL
    
    var formattedID : String{
        get {
            return String(format: "#%03d", id)
        }
    }
    
    var type1 : String{
        get {
            return types[0].type.name.capitalized
        }
    }
    
    var type2 : String{
        get {
            if types.count < 2 {
                return ""
            }
            return types[1].type.name.capitalized
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
        self.sprite = (listResult.shiny ? URL(string: listResult.shinySprite) : URL(string: listResult.sprite))!
    }
}
