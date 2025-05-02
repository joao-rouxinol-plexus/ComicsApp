//
//  MainViewModel.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//

import Foundation
import UIKit
import CryptoKit

class MarvelMainViewModel {
    
    // MARK: - Properties
    var isLoading: MarvelObservable <Bool> = MarvelObservable(false) //controla o carregamento dos dados (se estao a ser carregados ou nao )
    var cellDataSource: MarvelObservable<[MarvelCharacterViewModel]> = MarvelObservable(nil)
    var dataSource: [Character]?
    
    // MARK: - UI Management Methods
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    // MARK: - Networking Methods
    func getData(offset: Int) {
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        
        MarvelAPICaller.getCharactersInfo(offset: offset) { [weak self] characters in
            guard let self = self else { return }
            self.isLoading.value = false
            guard !characters.isEmpty else { return }

            
            if self.dataSource == nil {
                self.dataSource = characters
            } else {
                self.dataSource?.append(contentsOf: characters)
            }
            self.mapCellData()
        }
        MarvelNetworkConstant.shared.offset += MarvelNetworkConstant.shared.limit
    }
    
    // MARK: - Data Management Methods
    func mapCellData() {
        guard let dataSource = self.dataSource, !dataSource.isEmpty else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let mappedData = dataSource.map { MarvelCharacterViewModel(character: $0) }
            
            DispatchQueue.main.async {
                self.cellDataSource.value = mappedData
            }
        }
    }
}

