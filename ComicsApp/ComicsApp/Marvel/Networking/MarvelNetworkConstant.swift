//
//  NetworkConstant.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 07/03/2025.
//

import Foundation
import CryptoKit

class MarvelNetworkConstant{
    
    // MARK: - Singleton Instance
    public static var shared: MarvelNetworkConstant = MarvelNetworkConstant()
    
    private init(){
        //Singletone
    }
    
    // MARK: - Public Properties
    public var apiKey:String{
        get{
            return "b18356b0bd09f22fb50be8003571c0e4"
        }
        
    }
    
    public var privateKey:String{
        get{
            return "f7d099892caeac722585841e1a996725283d7e8f"
        }
    }
    
    public var ts:String{
        get{
            return String(Int(Date().timeIntervalSince1970))
            
        }
    }
    
    public var hash:String{
        get{
            return md5(data: "\(ts)\(privateKey)\(apiKey)")
        }
    }
    
    public var serverAdress:String{
        get{
            return "https://gateway.marvel.com/v1/public/"
        }
    }
    
    // MARK: - Pagination Properties
    var offset: Int = 0
    var limit: Int = 10
    var total = 1564 //NAO DEIXAR ASSIM
    
    // MARK: - Private Methods
    private func md5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
