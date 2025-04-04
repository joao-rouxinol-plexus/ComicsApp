//
//  PokemonViewModel.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 20/03/2025.
//


struct PokemonTypeViewModel {
    let name : String
    let id : Int
//    let Sprite : String
    
    
    init(type: PokemonTypeInfo) {
        self.name = type.name
        self.id = type.id
//        self.Sprite = type.sprites.generationViii.sword_shield.name_icon
    }
}

