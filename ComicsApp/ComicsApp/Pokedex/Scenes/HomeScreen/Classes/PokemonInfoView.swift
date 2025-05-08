//
//  InfoView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonInfoView : UIView {
    
    private var nameAndNumberView : PokemonNameAndNumberView = PokemonNameAndNumberView()
    private var typeView : PokemonTypeView = PokemonTypeView()
    private var isAccessible : Bool
    
    init(isAccessible: Bool = false){
        self.isAccessible = isAccessible
        super.init(frame: .zero)
        addSubview(nameAndNumberView)
        addSubview(typeView)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(id: String, name: String, type1: String, type2: String){
        nameAndNumberView.configure(id: id, name: name)
        typeView.configure(type1: type1, type2: type2)
        
        if isAccessible{
            isAccessibilityElement = true
            accessibilityLabel = "\(id), \(name), Type \(type1), \(type2)"
            nameAndNumberView.makeScaleable()
            typeView.makeScaleable()
        }
    }
    
    func setOrientation(useVerticalLayout: Bool){
        nameAndNumberView.setOrientation(useVerticalLayout: useVerticalLayout)
        typeView.setOrientation(useVerticalLayout: useVerticalLayout)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            nameAndNumberView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameAndNumberView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameAndNumberView.widthAnchor.constraint(equalTo: widthAnchor),
            
            typeView.topAnchor.constraint(equalTo: nameAndNumberView.bottomAnchor, constant: 10),
            typeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            typeView.widthAnchor.constraint(equalTo: widthAnchor),
            bottomAnchor.constraint(equalTo: typeView.bottomAnchor, constant: 0)
        ])
    }
}
