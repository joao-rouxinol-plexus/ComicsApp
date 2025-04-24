//
//  PokemonViewModel.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 20/03/2025.
//

struct StatViewModel {
    let name : String
    let value : Int
}

struct PokemonViewModel {
    let name : String
    let id : Int
    let species : species
    let types : [Types]
    let sprite : String
    let shinySprite : String
    let abilities : [Abilities]
    let statsVM : [StatViewModel]
    let largestStatName : String
    let largestStat : Int
    let height : Int
    let weight : Int

    var shiny : Bool = {
        let random = Int.random(in: 1...50)
        if (random == 1){
            return true
        }
        else {
            return false
        }
    }()
    
    var shinyCorrectedSprite : String {
        shiny ? shinySprite : sprite
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
    
    init(pokemon: Pokemon) {
        self.name = pokemon.name.split(separator: "-").joined(separator: " ").capitalized
        self.id = pokemon.id
        self.species = pokemon.species
        self.types = pokemon.types
        self.sprite = pokemon.sprites.other.officialArtwork.front_default
        self.shinySprite = pokemon.sprites.other.officialArtwork.front_shiny
        self.abilities = pokemon.abilities
        var tempStatsVM : [StatViewModel] = []
        var tempLargestStat : Int = 0
        var tempLargestStatName : String = ""
        for stat in pokemon.stats {
            let currentStatName : String = stat.stat.name.split(separator: "-").joined(separator: " ").capitalized
            tempStatsVM.append(StatViewModel(name: currentStatName, value: stat.base_stat))
            if (stat.base_stat > tempLargestStat){
                tempLargestStat = stat.base_stat
            }
            if (currentStatName.count > tempLargestStatName.count){
                tempLargestStatName = currentStatName
            }
        }
        self.height = pokemon.height * 10
        self.weight = pokemon.weight * 100
        self.statsVM = tempStatsVM
        self.largestStat = tempLargestStat
        self.largestStatName = tempLargestStatName
    }
}

