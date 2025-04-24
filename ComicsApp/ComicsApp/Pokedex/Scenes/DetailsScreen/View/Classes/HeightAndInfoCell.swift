//
//  HeightAndInfoCell.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class HeightAndInfoCell : UIView {
    
    let heightPill: UILabel = {
        let label = UILabel()
        label.squircle()
        
        let baseFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.borderWidth = 3
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightPill: UILabel = {
        let view = UILabel()
        view.squircle()
        
        let baseFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        view.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        view.adjustsFontForContentSizeCategory = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.textColor = .black
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textColor = .darkText
        let baseFont = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textColor = .darkText
        let baseFont = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
            
            heightLabel.bottomAnchor.constraint(equalTo:bottomAnchor),
        ])
    }
}
