//
//  MainViewController.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//
import Foundation
import UIKit

class MarvelMainScreenViewController: UIViewController {
    
   
    //IBoutlets:
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
     let searchController = UISearchController(searchResultsController: nil)
    //ViewModel
    var viewModel: MarvelMainViewModel = MarvelMainViewModel()
    
    //Variables
    var cellDataSource : [CharacterTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
        self.setUpSearchController()
    }
    
    func configView(){
        self.title = "MarvelApp"
        self.view.backgroundColor = .red
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self , let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating( )
                }else {
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
        viewModel.cellDataSource.bind { [weak self] Characters in
            guard let self = self, let Characters = Characters else {
                return
            }
            self.cellDataSource = Characters
            self.reloadTableView()
        }
    }
    
    private func setUpSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Marvel Characters"
    
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
        
}

