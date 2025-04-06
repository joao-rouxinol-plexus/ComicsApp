//
//  TestMainViewController.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//

import UIKit

class RickMortyMainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel : RickMortyMainViewModel = RickMortyMainViewModel()
    var cellDataSource : [CharacterTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
        bindViewModel()
    }

    func configView(){
        
        self.title = "Characters"
        self.view.backgroundColor = .white
        
        setupTableView()
        viewModel.getData()
    }
    
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self ,let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                }else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] characters in
            guard let self = self, let characters = characters else {
                return
            }
            
            self.cellDataSource = characters
                self.reloadTableView()

        }
    }
    
    func openDetail(charaterId: Int){
        guard let character = viewModel.retrieveCharacter(whit: charaterId) else{
            return
        }
        let detailsViewModel = CharacterDetailsViewModel(character: character)
        let detailsController = CharactersDetailsController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
}
