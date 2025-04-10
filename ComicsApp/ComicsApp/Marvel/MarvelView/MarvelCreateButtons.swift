//
//  MarvelCreateButtons.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 03/04/2025.
//

import Foundation
import UIKit

class MarvelCreateButtons {
    static func createButton(title: String, action: Selector) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.systemYellow, for: .normal)
            button.titleLabel?.font = UIFont(name: "Impact", size: 15)
            button.addBorder(color: .systemYellow, width: 1)
            button.layer.cornerRadius = 8
            button.addTarget(nil, action: action, for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    }
}
