//
//  ApiCaller.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation
import UIKit

public class PokemonApiCaller {
    
    static func getSpeciesInfo(pokemonID: Int, completionHandler: @escaping (_ result: PokemonSpecies) -> Void) {
        
        let urlstring = PokemonNetworkConstants().speciesURL + "\(pokemonID)"
        let url = URL(string: urlstring)!
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonSpecies.self, from: data) {
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(dataResponse!)")
            }
        }.resume()
    }
    
    
    static func listSpecies(urlstring: String, completionHandler: @escaping (_ result: PokemonSpeciesList) -> Void) {
        
        let url = URL(string: urlstring)!
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonSpeciesList.self, from: data) {
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(dataResponse!)")
            }
        }.resume()
    }
}
