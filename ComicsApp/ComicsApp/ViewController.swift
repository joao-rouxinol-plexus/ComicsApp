//
//  ViewController.swift
//  ComicsApp
//
//  Created by João Rouxinol on 06/03/2025.
//

import UIKit

class ViewController: UIViewController {
    
    let pokedexVC = PokeDexMainScreenViewController()
    let MarvelVC = MarvelMainScreenViewController()
    let RMVC = RickAndMortyMainScreenViewController()
    
    var color : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = self.navigationController {
            color = navigationController.navigationBar.tintColor
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = color
        }
        // TODO: REMOVER
//        PokeButton(UIButton())
    }
    
    
    @IBAction func PokeButton(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(pokedexVC, animated: true)
            navigationController.navigationBar.tintColor = .red
        }
        
    }
    
    @IBAction func MarvelButton(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(MarvelVC, animated: true)
            //            navigationController.navigationBar.tintColor = .blue
        }
        
    }
    
    @IBAction func RMButton(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(RMVC, animated: true)
            //            navigationController.navigationBar.tintColor = .systemGreen
        }
    }
    
}

