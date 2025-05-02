//
//  ViewController.swift
//  ComicsApp
//
//  Created by João Rouxinol on 06/03/2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let detailView: ViewControllerView
    private let viewModel : ViewControllerViewModel
    
    private let pokedexVC = PokeDexMainScreenViewController()
    private let MarvelVC = MarvelMainScreenViewController()
    private let RMVC = RickMortyMainViewController()
    
    init(detailView : ViewControllerView, viewModel : ViewControllerViewModel) {
        self.detailView = detailView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comics App"
        
        detailView.getUniverseTapped = { [weak self] tappedImg in
            
            switch tappedImg{
            case .pokemon:
                if let navigationController = self?.navigationController {
                    navigationController.pushViewController(self!.pokedexVC, animated: true)
                }
            case .marvel:
                if let navigationController = self?.navigationController {
                    navigationController.pushViewController(self!.MarvelVC, animated: true)
                }
            case .rm:
                if let navigationController = self?.navigationController {
                    navigationController.pushViewController(self!.RMVC, animated: true)
                }
            }
            
        }
        
    }
}
