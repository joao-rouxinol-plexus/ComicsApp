//
//  BoxView.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 28/03/2025.
//

import Foundation
import UIKit
import Foundation
import UIKit

class MarvelBoxView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 20)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    init(title: String, content: String) {
        super.init(frame: .zero)
        self.backgroundColor = .boxBackgroundColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.systemYellow.cgColor
        self.layer.borderWidth = 2
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = title
        contentLabel.text = content
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setup(){
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Update Methods
    func updateContent(_ content: String) {
        contentLabel.text = content
    }
}

