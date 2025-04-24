//
//  pokeTypeView.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 24/04/2025.
//

import UIKit

class pokeTypeView: UIView {
    
    let type1View: UILabel = {
        let view = UILabel()
        view.squircle()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.textColor = .label
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let type2View: UILabel = {
        let view = UILabel()
        view.squircle()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.textColor = .label
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(type1: String, type2: String){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure(type1: type1, type2: type2)
    }
    
    func configure(type1: String, type2: String){
        subviews.forEach({$0.removeFromSuperview()})
        
        type1View.text = type1
        type2View.text = type2
        addSubview(type1View)
        
        NSLayoutConstraint.activate([
            type1View.topAnchor.constraint(equalTo: topAnchor),
            type1View.leadingAnchor.constraint(equalTo: leadingAnchor),
            type1View.heightAnchor.constraint(equalToConstant: 30)])
        
        if (type2 != "") {
            addSubview(type2View)
            NSLayoutConstraint.activate([
                type2View.topAnchor.constraint(equalTo: topAnchor),
                type2View.leadingAnchor.constraint(equalTo: type1View.trailingAnchor, constant: 10),
                type2View.trailingAnchor.constraint(equalTo: trailingAnchor),
                type2View.widthAnchor.constraint(equalTo: type1View.widthAnchor),
                type2View.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                type1View.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
