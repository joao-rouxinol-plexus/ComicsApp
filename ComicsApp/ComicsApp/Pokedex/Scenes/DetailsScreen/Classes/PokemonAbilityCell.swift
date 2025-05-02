//
//  AbilityCell.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonAbilityCell : UIView {
    
    var isHiddenAbility : Bool = false
    
    let hiddenAbilityView : UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "Hidden"
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular).makeScaleable()
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        label.isAccessibilityElement = false
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium).makeScaleable()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.textAlignment = .center
        return label
    }()
    
    init(name: String, hidden: Bool = false){
        self.nameLabel.text = name
        self.isHiddenAbility = hidden
        super.init(frame: .zero)
        if isHiddenAbility {
            self.nameLabel.accessibilityLabel = "\(name), Hidden"
        }
        translatesAutoresizingMaskIntoConstraints = false
        squircle()
        PrepareDetails()
    }
    
    func PrepareDetails(){
        addSubview(nameLabel)
        addSubview(hiddenAbilityView)
        hiddenAbilityView.isHidden = !isHiddenAbility
        addConstraints()
    }
    
    func setOrientation(useVerticalLayout: Bool){
        addConstraints(useVerticalLayout: useVerticalLayout)
    }
    
    func addConstraints(useVerticalLayout: Bool = false) {
        
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
        ])
        
        if (!useVerticalLayout || !isHiddenAbility){
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
                hiddenAbilityView.leadingAnchor.constraint(equalTo: leadingAnchor),
                hiddenAbilityView.heightAnchor.constraint(equalTo: heightAnchor),
                hiddenAbilityView.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: 0.2)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                hiddenAbilityView.topAnchor.constraint(equalTo: topAnchor),
                hiddenAbilityView.leadingAnchor.constraint(equalTo: leadingAnchor),
                hiddenAbilityView.widthAnchor.constraint(equalTo: widthAnchor),
                hiddenAbilityView.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
                nameLabel.topAnchor.constraint(equalTo: hiddenAbilityView.bottomAnchor),
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
