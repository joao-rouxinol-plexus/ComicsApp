//
//  PokemonNetworkConstants.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

class PokemonNetworkConstants{
    
    public static var shared: PokemonNetworkConstants = PokemonNetworkConstants()
    
    public var pokemonURL: String {
        get {
            return "https://pokeapi.co/api/v2/pokemon/"
        }
    }
    
    public var speciesURL: String {
        get {
            return "https://pokeapi.co/api/v2/pokemon-species/"
        }
    }
    
    public var offsetURL: String {
        get {
            return "offset="
        }
    }
    
    public var limitURL: String {
        get {
            return "limit="
        }
    }
}
