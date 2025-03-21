//
//  NetworkConstant.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//

class NetworkConstant{
    
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init(){}
    
  public var serverURL: String {
      get {
          return "https://rickandmortyapi.com/api/character"

      }
    }
}
