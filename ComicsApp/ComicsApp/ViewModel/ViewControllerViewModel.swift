//
//  ViewControllerViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 8/4/25.
//

import UIKit

class ViewControllerViewModel {
    
    weak var navigationController : UINavigationController?
    
    public var pokemonImage:  UIImage? {
        return UIImage(named: "pokemon")
    }
    
    public var marvelImage:  UIImage? {
        return UIImage(named: "marvel")
    }
    
    public var rmImage:  UIImage? {
        return UIImage(named: "rm")
    }
}
