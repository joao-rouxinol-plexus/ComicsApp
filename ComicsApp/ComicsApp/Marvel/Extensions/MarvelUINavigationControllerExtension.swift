//
//  MarvelUINavigationControllerExtension.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 28/03/2025.
//

import Foundation
import UIKit

extension UINavigationController {
    func setupMarvelNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundColor
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.systemYellow,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.systemYellow
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .systemYellow
    }
}


