//
//  UISearchController.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 13/03/2025.
//

import UIKit

extension MarvelMainScreenViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text ?? "")
        print("Search Bar:\(String(describing: searchController.searchBar.text))")
    }
}
