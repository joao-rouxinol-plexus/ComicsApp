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
        guard let searchText = searchBarText?.lowercased() else { return }
        
        if searchText.isEmpty {
            self.cellDataSource.value = dataSource?.map { MarvelCharacterViewModel(character: $0) } ?? []
        } else {
            self.cellDataSource.value = dataSource?.filter {
                $0.name?.lowercased().contains(searchText) ?? false
            }.map { MarvelCharacterViewModel(character: $0) } ?? []
        }
    }
    
}

