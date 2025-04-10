//
//  Observable.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//

import Foundation

class Observable<T> {
    
    var value: T?{
        didSet{
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?)-> Void)?
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
