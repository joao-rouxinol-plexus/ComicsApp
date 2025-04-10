//
//  UIViewExtensions.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 11/03/2025.
//

import Foundation
import UIKit

extension UIView {
    func round (_ radiuis: CGFloat = 10) {
        self.layer.cornerRadius = radiuis
        self.clipsToBounds = true
    }
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
