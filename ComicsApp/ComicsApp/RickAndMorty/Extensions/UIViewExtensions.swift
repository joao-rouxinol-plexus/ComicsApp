//
//  UIViewExtensions.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 14/3/25.
//

import UIKit

extension UIView {
    
    func round(_ radius: CGFloat = 10) {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor = .systemGray, width: CGFloat = 2) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
