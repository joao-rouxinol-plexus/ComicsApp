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
    
    //ViewModel
    var viewModel: MarvelMainViewModel = MarvelMainViewModel()
    
    //Variaveis
    var cellDataSource : [CharacterTableCellViewModel] = []
    
    //Paginação
    var footerView: UIView!
    var topButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        bindViewModel()
        navBar()
    }
    
    func configView(){
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData(offset: NetworkConstant.shared.offset)
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
                    self.setupFooterView()
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
    
    func navBar(){
        self.title = "MarvelApp"
        self.view.backgroundColor = .black
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        //MarveApp cor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        //MarvelApp tamanho e bold
        appearance.titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow,
                .font: UIFont.boldSystemFont(ofSize: 20)
                ]
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemYellow] //muda a cor do botão Back
        
        //header? nao mudar de cor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .systemYellow //muda a cor da < do botao back
    }

        
}
