//
//  PokemonApiCaller.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation
import UIKit

public class PokemonApiCaller {
    
    static func getPokemonInfo(urlString: String, completionHandler: @escaping (_ result: Pokemon) -> Void) {
        
        let url = URL(string: urlString)!
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(Pokemon.self, from: data) {
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(String(describing: dataResponse))")
            }
        }.resume()
    }
    
    
    static func listSpecies(urlstring: String, completionHandler: @escaping (_ result: PokemonList) -> Void) {
        
        let url = URL(string: urlstring)!
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonList.self, from: data) {
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(String(describing: dataResponse))")
            }
        }.resume()
    }
}
