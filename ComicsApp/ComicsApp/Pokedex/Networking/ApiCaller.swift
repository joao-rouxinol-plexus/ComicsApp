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
        
        print(urlstring)
        let url = URL(string: urlstring)!
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonSpecies.self, from: data) {
                print("Decoded successfully: \(resultData)")
                completionHandler(resultData)
            } else {
                print("rawdata: \(dataResponse!)")
            }
        }.resume()
        
    }
    
    
    static func listSpecies(completionHandler: @escaping (_ result: SpeciesList) -> Void) {
        let urlstring = "\(NetworkConstants().speciesURL)\(NetworkConstants().limitURL)3000"
        
        print(urlstring)
        let url = URL(string: urlstring)!
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(SpeciesList.self, from: data) {
                print("Decoded successfully: \(resultData)")
                completionHandler(resultData)
            } else {
                print("rawdata: \(dataResponse!)")
            }
        }.resume()
        
        
    }
}
