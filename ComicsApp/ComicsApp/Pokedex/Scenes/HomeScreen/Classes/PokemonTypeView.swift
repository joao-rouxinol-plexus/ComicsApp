//
//  pokeTypeView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonTypeView: UIView {
    
    private static func createTypeLabel() -> UILabel {
        let label = UILabel()
        label.squircle()
        label.layer.borderColor = UIColor.white.cgColor
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        
        label.layer.borderWidth = 1
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private let type1Label = createTypeLabel()
    
    private let type2Label = createTypeLabel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }
    
    func configure(type1: String, type2: String) {
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        type1Label.text = type1
        stackView.addArrangedSubview(type1Label)
        
        if !type2.isEmpty {
            type2Label.text = type2
            stackView.addArrangedSubview(type2Label)
        }
    }
    
    func setOrientation(useVerticalLayout: Bool){
        if useVerticalLayout{
            stackView.axis = .vertical
        }
        else {
            stackView.axis = .horizontal
        }
    }
    
    func makeScaleable() {
        type1Label.font = type1Label.font.makeScaleable()
        type2Label.font = type2Label.font.makeScaleable()
    }
}
