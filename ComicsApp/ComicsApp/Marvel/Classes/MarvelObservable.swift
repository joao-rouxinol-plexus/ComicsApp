//
//  Observable.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 10/03/2025.
//

import Foundation

class MarvelObservable <T> {
    
    // MARK: - Properties
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listeners?(self.value)
            }
        }
    }
    
    private var listeners: ((T?) -> Void)?
    
    // MARK: - Initializer
    init (_ value : T?) {
        self.value = value
    }
    
    // MARK: - Binding
    func bind(_ listener: @escaping (T?) -> Void) {
        self.listeners = listener
    }
}
