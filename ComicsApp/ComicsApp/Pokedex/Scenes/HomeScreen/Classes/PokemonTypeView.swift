//
//  pokeTypeView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonTypeView: UIView {
    
    private func createTypeLabel() -> UILabel {
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
    
    private lazy var type1Label = createTypeLabel()
    
    private lazy var type2Label = createTypeLabel()
    
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
        type2Label.text = type2
        
        stackView.addArrangedSubview(type1Label)
        stackView.addArrangedSubview(type2Label)
        
        type2Label.isHidden = type2.isEmpty
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
        type1Label.textColor = .white
        type2Label.textColor = .white
    }
}
