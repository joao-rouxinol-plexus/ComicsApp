//
//  APICaller.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 07/03/2025.
//

import Foundation

import Foundation

// MARK: - Network Error Enum
enum NetworkError: Error {
    case urlError
    case canNotParseData
    case networkError(Error)
}

// MARK: - Marvel API Caller
public class MarvelAPICaller {
    static var useMockData = false
    
    // MARK: - Public API Methods
    static func getCharactersInfo(offset: Int, completionHandler: @escaping (_ result: [Character]) -> Void) {
        if useMockData {
            fetchMockData(completionHandler: completionHandler)
        } else {
            fetchFromAPI(offset: offset, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private API Methods
    private static func fetchFromAPI(offset: Int, completionHandler: @escaping (_ result: [Character]) -> Void) {
        let urlString = MarvelNetworkConstant.shared.serverAdress + "/characters?ts=" + MarvelNetworkConstant.shared.ts + "&apikey=" + MarvelNetworkConstant.shared.apiKey + "&hash=" + MarvelNetworkConstant.shared.hash + "&offset=" + "\(MarvelNetworkConstant.shared.offset)" + "&limit=" + "\(MarvelNetworkConstant.shared.limit)"
        
        guard let url = URL(string: urlString) else {
            print("Erro: URL inválida")
            return
        }
        
        print(urlString)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { // confirma se o url é valido
                print("Erro de rede: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(MarvelCharactersModel.self, from: data) //se houver json tenta converter para MarvelCharacterModel
                    DispatchQueue.main.async {
                        completionHandler(response.data.results) //volta a enviara para o viewModel
                    }
                } catch {
                    print("Erro ao descodificar os dados: \(error)")
                }
            } else {
                print("Erro: Dados não recebidos.")
            }
        }.resume()
    }
    
    private static func fetchMockData(completionHandler: @escaping (_ result: [Character]) -> Void) {
        if let characters = loadMockData() {
            DispatchQueue.main.async {
                completionHandler(characters)
            }
        } else {
            print("Erro: Não foi possível carregar os dados do mockData.json")
        }
    }
    
    private static func loadMockData() -> [Character]? {
        if let url = Bundle.main.url(forResource: "mockData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
                return decodedData.data.results
            } catch {
                print("Erro ao carregar JSON: \(error)")
            }
        }
        return nil
    }
}

