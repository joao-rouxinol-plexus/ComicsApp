//
//  Quote.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation



struct results: Codable {
    let name : String
    let url : String
}

struct SpeciesList: Codable {
    var count : Int
    let next : String?
    let previous : String?
    let results : [results]
}


