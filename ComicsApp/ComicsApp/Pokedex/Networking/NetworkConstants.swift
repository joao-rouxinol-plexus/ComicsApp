//
//  NetworkConstants.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

class NetworkConstants{
    public static var shared: NetworkConstants = NetworkConstants()
    
    public var speciesURL: String {
         get {
             return "https://pokeapi.co/api/v2/pokemon-species/"
         }
     }
    
    public var limitURL: String {
        get {
            return "?limit="
        }
    }
    
    public var spriteURL: String {
        get {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        }
    }
}
