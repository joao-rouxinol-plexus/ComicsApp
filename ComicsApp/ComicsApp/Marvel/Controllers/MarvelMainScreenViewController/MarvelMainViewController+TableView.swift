//
//  MainViewController+TableView.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//

import Foundation
import UIKit

extension MarvelMainScreenViewController : UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
    }
    
    func registerCells(){
        tableView.register(MainCharacterCell.register(),forCellReuseIdentifier: MainCharacterCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRows(in: section)
        let inSearchMode = self.viewModel.inSearchMode(self.searchController)
        return inSearchMode ? self.viewModel.filteredCharacters.count : self.viewModel.numberOfRows(in: section)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacterCell.identifier, for: indexPath) as? MainCharacterCell else {
//            return UITableViewCell()
//        }
//        let inSearchMode = self.viewModel.inSearchMode(searchController)
//        
//        let character = inSearchMode ? self.viewModel.filteredCharacters[indexPath.row] : self.viewModel.dataSource![indexPath.row]
//        
//        cell.setUpCell(viewModel:character)
//        
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacterCell.identifier, for: indexPath) as? MainCharacterCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setUpCell(viewModel:cellViewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    

    
}
