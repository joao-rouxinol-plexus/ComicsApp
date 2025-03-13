//
//  UILabelExtensions.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 12/03/2025.
//

import UIKit

extension String{
    var bold: NSAttributedString {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
            ]
            return NSAttributedString(string: self, attributes: attributes)
    }
    
    func boldPart(range: NSRange) -> NSAttributedString {
            let mutableAttributedString = NSMutableAttributedString(string: self)
            mutableAttributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize),
                range: range
            )
            return mutableAttributedString
        }
    
}
