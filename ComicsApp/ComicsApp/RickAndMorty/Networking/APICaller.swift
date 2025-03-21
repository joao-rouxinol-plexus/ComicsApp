//
//  APICaller.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//

import Foundation


enum NetworkError: Error {
    case noData
    case decodingError
    case invalidURL
    case urlRequestFailed
}


public class APICaller{
    
    private static var baseURL: String  = NetworkConstant.shared.serverURL
    private static var isFetching = false
    
    
    static func getCharacters(from urlString: String, completionHandler: @escaping((_ result: Result<CharactersModel, NetworkError>) -> Void)) {
        
        
        guard let url = URL(string: urlString), !isFetching else{
            completionHandler(.failure(.invalidURL))
            return
            
        }
        
        isFetching = true
        
        URLSession.shared.dataTask(with: url){ dataResponse, urlResponse, error in
            
            defer{  isFetching = false}
            
            if let error = error {
                print("Error: \(error)")
                completionHandler(.failure(.urlRequestFailed))
                return
            }
            
            guard let data = dataResponse else {
                completionHandler(.failure(.noData))
                return
            }
            
            
            do{
                let resultData = try JSONDecoder().decode(CharactersModel.self, from: data)
                DispatchQueue.main.async{
                    completionHandler(.success(resultData))
                }
            }catch{
                print(error)
                completionHandler(.failure(.decodingError))
            }
        }.resume()
    }
}
