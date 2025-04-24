//
//  StatCell.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class StatCell : UIView {
    
    let statBarLimit : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let statBar : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.squircle()
        return view
    }()
    
    let textBackgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.squircle()
        return view
    }()
    
    let nameSpacer : UILabel = {
        let label = UILabel()
        let baseFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .clear
        label.isAccessibilityElement = false
        
        return label
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        let baseFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .darkText
        
        return label
    }()
    
    let valueLabel : UILabel = {
        let label = UILabel()
        let baseFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: baseFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        
        return label
    }()
    
    init(name: String, value: Int, largestName: String){
        self.nameLabel.text = name
        self.nameSpacer.text = largestName
        self.valueLabel.text = String(value)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        squircle()
        setupHierarchy()
        addConstraints()
    }
    
    func setupHierarchy(){
        addSubview(statBarLimit)
        statBarLimit.addSubview(statBar)
        addSubview(textBackgroundView)
        addSubview(valueLabel)
        addSubview(nameSpacer)
        addSubview(nameLabel)
    }
    
    func setOrientation(preferredContentSizeCategory: UIContentSizeCategory){
        var height = 0
        if preferredContentSizeCategory < .accessibilityMedium {
            height = 30
            nameLabel.text = nameLabel.text?.replacingOccurrences(of: "\n", with: " ")
            nameSpacer.text = nameSpacer.text?.replacingOccurrences(of: "\n", with: " ")
        }
        else if preferredContentSizeCategory >= .accessibilityMedium {
            height = 60
            nameLabel.text = nameLabel.text?.replacingOccurrences(of: " ", with: "\n")
            nameSpacer.text = nameSpacer.text?.replacingOccurrences(of: " ", with: "\n")
        }
        
        addConstraints(cellHeight: height)
    }
    
    func addConstraints(cellHeight: Int = 30) {
        
        NSLayoutConstraint.deactivate(constraints)
        
        var constraints : [NSLayoutConstraint] = []
        
        constraints.append(heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(cellHeight)))
        constraints.append(heightAnchor.constraint(equalTo: textBackgroundView.heightAnchor))
        constraints.append(textBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor))
        
        
        constraints.append(nameLabel.heightAnchor.constraint(equalTo: heightAnchor))
        constraints.append(nameLabel.centerYAnchor.constraint(equalTo:centerYAnchor))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 10))
        
        constraints.append(nameSpacer.heightAnchor.constraint(equalTo: heightAnchor))
        constraints.append(nameSpacer.centerYAnchor.constraint(equalTo:centerYAnchor))
        constraints.append(nameSpacer.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 10))
        constraints.append(textBackgroundView.trailingAnchor.constraint(equalTo: nameSpacer.trailingAnchor, constant: 10))
        
        
        constraints.append(statBarLimit.leadingAnchor.constraint(equalTo: textBackgroundView.trailingAnchor, constant: 0))
        constraints.append(statBarLimit.heightAnchor.constraint(equalTo: heightAnchor))
        constraints.append(statBarLimit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0))
        constraints.append(statBarLimit.topAnchor.constraint(equalTo: topAnchor))
        
        constraints.append(statBar.heightAnchor.constraint(equalTo: statBarLimit.heightAnchor))
        constraints.append(statBar.topAnchor.constraint(equalTo: statBarLimit.topAnchor))
        constraints.append(statBar.leadingAnchor.constraint(equalTo: statBarLimit.leadingAnchor, constant: -10))
        
        constraints.append(valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        constraints.append(valueLabel.trailingAnchor.constraint(equalTo:statBar.trailingAnchor, constant: -15))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
