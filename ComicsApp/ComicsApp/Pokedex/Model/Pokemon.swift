//
//  Quote.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation


struct types: Codable {
    let slot : Int
    let type : type
}

struct type: Codable{
    let name : String
    let url : String
}

struct species: Codable{
    let name : String
    let url : String
}

struct Pokemon: Codable {
    let name : String
    let id : Int
    let species : species
    let types : [types]
    
    

}


