//
//  Rick_MortyMainViewController+TableViewController.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//


import Foundation
import UIKit

extension RickMortyMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.registerCells()
    }
    
    func registerCells(){
        tableView.register(CharacterViewCell.register(), forCellReuseIdentifier: CharacterViewCell.identifier)
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.cellDataSource = self.viewModel.cellDataSource.value ?? []
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row < cellDataSource.count else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, for: indexPath) as? CharacterViewCell else{
            return UITableViewCell()
        }
        
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setUpCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellDataSource.count - 10{
                viewModel.loadMoreCharacters()
            
       }
    }
    
}

