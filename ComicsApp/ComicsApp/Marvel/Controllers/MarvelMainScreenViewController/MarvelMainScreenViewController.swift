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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setupMarvelNavBar()
    }
    
    // MARK: - Setup
    func setup() {
        setupTableView()
        let titleLabel = UILabel()
        let baseFont = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: baseFont)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "MarvelApp"
        titleLabel.textColor = .systemYellow
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityLabel = "Marvel App"
        self.navigationItem.titleView = titleLabel
        
        self.view.backgroundColor = .backgroundColor
        setupSearchController()
        
        navigationController?.navigationBar.isAccessibilityElement = false
        navigationController?.navigationBar.accessibilityElementsHidden = true
    }
    
    // MARK: - Search Controller
    func setupSearchController() {
        tableView.backgroundColor = .backgroundColor
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.isAccessibilityElement = true
        searchController.searchBar.accessibilityLabel = "Search Bar"
        searchController.searchBar.accessibilityHint = "Search for characters"
        
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



