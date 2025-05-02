//
//  CharacterInformationCollectionViewCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit

final class CharacterInformationCollectionViewCellViewModel {
    
    private let type : `Type`
    private let value : String
    
    public var title : String {
        return type.displayTitle
    }
    
    public var displayValue : String {
        if value.isEmpty { return "N/A"
        }
        
        return value.capitalized
    }
    
    public var iconImage : UIImage? {
        
        switch type {
            
        case .status:
            
            if value == "Alive" {
                return UIImage(systemName: "person.fill")
            } else if value == "Dead" {
                return UIImage(systemName: "person.slash.fill")
            } else {
                return UIImage(systemName: "questionmark.diamond.fill")
            }
            
        case .gender:
            
            if value == "Male" {
                return UIImage(systemName: "figure.stand")
            } else if value == "Female" {
                return UIImage(systemName: "figure.stand.dress")
            } else {
                return UIImage(systemName: "questionmark.diamond.fill")
            }
            
        case .species:
            return UIImage(systemName: "person.3.fill")
            
        case .origin:
            return UIImage(systemName: "globe.europe.africa.fill")
        }
    }
    
    public var tintedColor : UIColor {
        return type.tintedColor
    }
    
    enum `Type` : String {
        
        case status
        case gender
        case species
        case origin
        
        
        
        var tintedColor: UIColor {
            
            switch self{
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            }
        }
        
        
        var displayTitle : String{
            
            switch self {
                
            case    .status,
                    .gender,
                    .species,
                    .origin:
                return rawValue.uppercased()
            }
        }
    }
    
    init(value: String, type: `Type`) {
        
        self.value = value
        self.type = type
    }
    
}
