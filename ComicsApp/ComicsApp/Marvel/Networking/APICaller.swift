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

    static func getCharactersInfo(completionHandler: @escaping (_ result: [Character]) -> Void) {
        // Construindo a URL corretamente
        let urlString = NetworkConstant.shared.serverAdress + "/characters?ts=" + NetworkConstant.shared.ts + "&apikey=" + NetworkConstant.shared.apiKey + "&hash=" + NetworkConstant.shared.hash + "&offset=" + "\(NetworkConstant.shared.offset)"
        
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
                    // Tentando decodificar a resposta
                    let response = try JSONDecoder().decode(CharactersModel.self, from: data)
                    
                    // Passando os resultados para o completionHandler
                    DispatchQueue.main.async {
                        completionHandler(response.data.results) // Passando os resultados diretamente
                    }
                } catch {
                    print("Erro ao decodificar os dados: \(error)")
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

