//
//  NameAndNumberView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonNameAndNumberView: UIView {
    
    let pokemonNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }()
    
    init(isScaleable : Bool = false){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(pokemonName)
        addSubview(pokemonNumber)
        addConstraints()
    }
    
    func configure(id: String, name: String){
        pokemonNumber.text="\(id)"
        pokemonName.text=name
    }
    
    func makeScaleable(){
        pokemonNumber.font = pokemonNumber.font.makeScaleable()
        pokemonName.font = pokemonName.font.makeScaleable()
    }
    
    func setOrientation(useVerticalLayout: Bool){
        addConstraints(useVerticalLayout: useVerticalLayout)
    }
    
    func addConstraints(useVerticalLayout : Bool = false){
        NSLayoutConstraint.deactivate(constraints)
        
        NSLayoutConstraint.activate([
            pokemonNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: pokemonName.bottomAnchor)
        ])
        
        if (!useVerticalLayout){
            NSLayoutConstraint.activate([
                pokemonNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
                pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor),
                pokemonName.leadingAnchor.constraint(greaterThanOrEqualTo: pokemonNumber.trailingAnchor, constant: 10)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                pokemonNumber.topAnchor.constraint(equalTo: topAnchor),
                pokemonNumber.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
                
                pokemonName.topAnchor.constraint(equalTo: pokemonNumber.bottomAnchor),
                pokemonName.leadingAnchor.constraint(equalTo: leadingAnchor),
                pokemonName.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
            ])
        }
        
        let constraint = pokemonName.centerXAnchor.constraint(equalTo: centerXAnchor)
        constraint.priority = .defaultLow
        constraint.isActive = true
        
        NSLayoutConstraint.activate([constraint])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
