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
        
        //        print(urlstring)
        let url = URL(string: urlstring)!
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(PokemonSpecies.self, from: data) {
                //                print("Decoded successfully: \(resultData)")
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(dataResponse!)")
            }
        }.resume()
        
    }
    
    
    static func listSpecies(urlstring: String, completionHandler: @escaping (_ result: SpeciesList) -> Void) {
        //        if urlstring == nil{
        //            let urlstring =  "\(NetworkConstants().speciesURL)\(NetworkConstants().offsetURL)\(offset)&\(NetworkConstants().limitURL)20&random=\(Int.random(in: 1...1))"
        //        }

//        print(urlstring)
        
        let url = URL(string: urlstring)!
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, err in
            if err == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(SpeciesList.self, from: data) {
                //                print("Decoded successfully: \(resultData)")
                completionHandler(resultData)
            } else {
                print("erro. rawdata: \(dataResponse!)")
            }
        }.resume()
        
        
    }
}
