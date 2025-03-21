//
//  APICaller.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 07/03/2025.
//

import Foundation

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
    case networkError(Error)
}

public class APICaller {
//rever esta parte
    static func getCharactersInfo(offset: Int, completionHandler: @escaping (_ result: [Character]) -> Void) {
        let urlString = NetworkConstant.shared.serverAdress + "/characters?ts=" + NetworkConstant.shared.ts + "&apikey=" + NetworkConstant.shared.apiKey + "&hash=" + NetworkConstant.shared.hash + "&offset=" + "\(NetworkConstant.shared.offset)" + "&limit=" + "\(NetworkConstant.shared.limit)"
        
        guard let url = URL(string: urlString) else {
            print("Erro: URL inválida")
            return
        }
        
        print(urlString)

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Erro de rede: \(error)")
                return
            }
            
            if let data = data {
                do {
                    
                    let response = try JSONDecoder().decode(CharactersModel.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(response.data.results)
                    }
                } catch {
                    print("Erro ao descodificar os dados: \(error)")
                }
            } else {
                print("Erro: Dados não recebidos.")
            }
        }.resume()
    }
    
    func fetchData(pagination: Bool = false, completion: (Result<[String], Error>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:{
            
        })
 
    }
}

