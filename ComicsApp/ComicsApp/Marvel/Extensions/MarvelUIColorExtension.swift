//
//  UIColorExtension.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 21/03/2025.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - My Colors
    static let textColor = UIColor(hex: "#EAEAEA")
    
    static let backgroundColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : UIColor(hex: "#0A1F44")
    }
    
    static let boxBackgroundColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#545454", alpha: 0.5) : UIColor(hex: "#555555", alpha: 0.5)
    }
    
    static let topButtonColor: UIColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? UIColor(hex: "#000000", alpha: 0.5) : UIColor(hex: "#0A1F44", alpha: 0.5)
    }
    
    // MARK: - Initializer
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}


