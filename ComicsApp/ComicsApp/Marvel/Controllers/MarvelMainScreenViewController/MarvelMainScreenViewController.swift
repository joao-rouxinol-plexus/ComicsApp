//
//  MainViewController.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//
import Foundation
import UIKit

class MarvelMainScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewModel
    var viewModel: MarvelMainViewModel = MarvelMainViewModel()
    
    var cellDataSource : [MarvelCharacterViewModel] = []
    
    var footerView: UIView!
    var topButton: UIButton!
    
    public let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData(offset: MarvelNetworkConstant.shared.offset)
    }
    // MARK: - Setup
    func setup(){
        setupTableView()
        navigationController?.setupMarvelNavBar()
        
        self.title = "MarvelApp"
        self.view.backgroundColor = .backgroundColor
        
        setupSearchController()
    }
    
    // MARK: - Search Controller
    func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [
                .foregroundColor: UIColor.textColor])
            textField.textColor = UIColor.textColor //cor do que escrevemos
            if let iconView = textField.leftView as? UIImageView {
                iconView.tintColor = UIColor.systemYellow // cor da lupa
            }
        }
    }
    
}



