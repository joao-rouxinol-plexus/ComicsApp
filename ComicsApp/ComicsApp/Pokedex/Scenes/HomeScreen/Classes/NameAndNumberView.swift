//
//  NameAndNumberView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class NameAndNumberView: UIView {
    
    let pokemonNumber: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    let pokemonName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20, weight: .regular)
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(pokemonName)
        addSubview(pokemonNumber)
        configureConstraints()
    }
    
    func configure(id: String, name: String){
        pokemonNumber.text="\(id)"
        pokemonName.text=name
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            pokemonNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
