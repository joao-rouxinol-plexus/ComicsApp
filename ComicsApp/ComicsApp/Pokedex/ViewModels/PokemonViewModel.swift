//
//  PokemonViewModel.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 20/03/2025.
//

struct PokemonViewModel {
    let name : String
    let id : Int
    let species : species
    let types : [Types]
    let sprite : String
    let shinySprite : String
    
    var shiny : Bool = {
        let random = Int.random(in: 1...25)
        if (random == 5){
            return true
        }
        else {
            return false
        }
    }()
    
    init(pokemon: Pokemon) {
        self.name = pokemon.name
        self.id = pokemon.id
        self.species = pokemon.species
        self.types = pokemon.types
        self.sprite = pokemon.sprites.other.officialArtwork.front_default
        self.shinySprite = pokemon.sprites.other.officialArtwork.front_shiny
    }
}

