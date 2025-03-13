//
//  ApiCaller.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation
import UIKit

public class ApiCaller {
    
    static func getSpeciesInfo(pokemonID: Int, completionHandler: @escaping (_ result: PokemonSpecies) -> Void) {
        
        let urlstring = NetworkConstants().speciesURL + "\(pokemonID)"
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
    
    
    static func listSpecies(urlstring: String, completionHandler: @escaping (_ result: SpeciesList) -> Void) {
        
        let url = URL(string: urlstring)!
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(SpeciesList.self, from: data) {
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(dataResponse!)")
            }
        }.resume()
    }
}
