//
//  HeightAndInfoCell.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class PokemonHeightAndInfoCell : UIView {
    
    private static func createPill() -> UILabel {
        let label = UILabel()
        label.squircle()
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular).makeScaleable()
        label.adjustsFontForContentSizeCategory = true
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.borderWidth = 3
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }
    
    let heightPill = createPill()
    
    let weightPill = createPill()
    
    private static func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium).makeScaleable()
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    let heightLabel = createLabel("Height")
    
    let weightLabel = createLabel("Weight")
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(heigth: String, weight: String){
        isAccessibilityElement = true
        accessibilityLabel = "Height: \(Double(heigth)!/100) m, Weight: \(Double(weight)!/1000) kg"
        subviews.forEach({$0.removeFromSuperview()})
        
        heightPill.text = "\(Double(heigth)!/100) m"
        weightPill.text = "\(Double(weight)!/1000) kg"
        addSubview(heightPill)
        addSubview(weightPill)
        addSubview(heightLabel)
        addSubview(weightLabel)
        
        addConstraints()
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.deactivate(constraints)
        
        NSLayoutConstraint.activate([
            heightPill.topAnchor.constraint(equalTo: topAnchor),
            heightPill.leadingAnchor.constraint(equalTo: leadingAnchor),
            heightPill.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            weightPill.topAnchor.constraint(equalTo: topAnchor),
            
            weightPill.leadingAnchor.constraint(equalTo: heightPill.trailingAnchor, constant: 10),
            weightPill.trailingAnchor.constraint(equalTo: trailingAnchor),
            weightPill.widthAnchor.constraint(equalTo: heightPill.widthAnchor),
            weightPill.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            heightLabel.topAnchor.constraint(equalTo: heightPill.bottomAnchor, constant: 3),
            heightLabel.centerXAnchor.constraint(equalTo: heightPill.centerXAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: weightPill.bottomAnchor, constant: 3),
            weightLabel.centerXAnchor.constraint(equalTo: weightPill.centerXAnchor),
            
            weightLabel.bottomAnchor.constraint(equalTo:heightLabel.bottomAnchor),
            heightLabel.bottomAnchor.constraint(equalTo:bottomAnchor),
        ])
    }
    
    func setOrientation(){
        addConstraints()
    }
}
