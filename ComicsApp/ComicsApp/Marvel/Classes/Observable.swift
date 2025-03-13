//
//  Observable.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 10/03/2025.
//

import Foundation

class Observable <T> {
    
    var value: T?{
        didSet{
            DispatchQueue.main.async {
                self.listeners?(self.value)
            }
        }
    }
    
    init (_ value : T?){
        self.value = value
    }
    
    private var listeners: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void){
        self.listeners = listener
    }
}
