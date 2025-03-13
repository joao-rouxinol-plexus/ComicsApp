//
//  NetworkConstant.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 07/03/2025.
//

import Foundation
import CryptoKit

class NetworkConstant{
    
    public static var shared: NetworkConstant = NetworkConstant()
        
    private init(){
        //Singletone
    }
    
    public var apiKey:String{
        get{
            return"2d3ac0101de18496f6b5c82497503ed8"
        }
        
    }
    
    public var privateKey:String{
        get{
            return "b1ab00f95232c2802df040e52a4083e33168296f"
        }
    }
    
    public var ts:String{
        get{
//            return "String(Int(Date().timeIntervalSince1970))"
            return "a"
        }
    }
    
    public var hash:String{
        get{
//            let ts = self.ts
//            let hashString = "\(ts)\(apiKey)\(privateKey)"
//            return md5(string: hashString)
            return "518c7de6ef16c5b29a2a64f64c67b037"
        }
    }
    
    
    public var serverAdress:String{
        get{
            return "https://gateway.marvel.com/v1/public/"
        }
    }
    
    public var offset: Int{
        get{
            return 0
        }
    }
    
//    public var imageServerAdress:String{
//        get{
//            return "http://i.annihil.us/u/prod/marvel/i/mg/"
//        }
//    }
    
    //Message Digest Algorithm 5
    private func md5(string: String) -> String {
        let data = Data(string.utf8)
        let hashed = Insecure.MD5.hash(data: data)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }
}
