//
//  UIViewModelExtensions.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 13/03/2025.
//

import UIKit
extension MarvelMainViewModel {
    
    public func inSearchMode (_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        return isActive && !searchText.isEmpty
    }
    public func updateSearchController(searchBarText: String?) {
        self.filteredCharacters = dataSource ?? []

        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else {
                self.onCharactersUpdated?()
                return
            }
            
            self.filteredCharacters = self.filteredCharacters.filter({ $0.name?.lowercased().contains(searchText) ?? false })
        }
        
        self.onCharactersUpdated?()
    }

}
