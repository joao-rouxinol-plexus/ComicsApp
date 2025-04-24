//
//  InfoView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class InfoView : UIView {
    
    private var nameandnumberview : NameAndNumberView = NameAndNumberView()
    private var poketypeview : pokeTypeView = pokeTypeView()
    private var isAccessible : Bool
    
    
    init(isAccessible: Bool = false){
        self.isAccessible = isAccessible
        super.init(frame: .zero)
        addSubview(nameandnumberview)
        addSubview(poketypeview)
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (id: String, name: String, type1: String, type2: String){
        nameandnumberview.configure(id: id, name: name)
        poketypeview.configure(type1: type1, type2: type2)
        
        if isAccessible{
            isAccessibilityElement = true
            accessibilityLabel = "Number \(id), \(name), Type \(type1), \(type2)"
        }
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            nameandnumberview.topAnchor.constraint(equalTo: topAnchor),
            nameandnumberview.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameandnumberview.widthAnchor.constraint(equalTo: widthAnchor),
            nameandnumberview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6666666),
            
            
            poketypeview.topAnchor.constraint(equalTo: nameandnumberview.bottomAnchor),
            poketypeview.trailingAnchor.constraint(equalTo: trailingAnchor),
            poketypeview.widthAnchor.constraint(equalTo: widthAnchor),
            poketypeview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
