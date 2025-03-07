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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func PokeButton(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            //            let pokedexVC = PokeDexMainScreenViewController()
            navigationController.pushViewController(pokedexVC, animated: true)
        }
        
    }
    
    @IBAction func MarvelButton(_ sender: UIButton) {
        //        present(MarvelVC, animated: true, completion: nil)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(MarvelVC, animated: true)
        }
        
    }
    
    @IBAction func RMButton(_ sender: UIButton) {
        //        present(RMVC, animated: true, completion: nil)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(RMVC, animated: true)
        }
    }
    
}

