//
//  MainViewModel.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//

import Foundation
import UIKit
import CryptoKit

class MarvelMainViewModel{
    
    var isLoading: Observable <Bool> = Observable(false)
    var cellDataSource: Observable<[CharacterTableCellViewModel]> = Observable(nil)
    var dataSource: [Character]?
    var filteredCharacters: [Character] = []
    var onCharactersUpdated: (()->Void)?

    func numberOfSections()->Int{
        1
    }
    
    func numberOfRows(in section: Int)->Int{
        return dataSource?.count ?? 0
    }
    
    func getData(offset: Int){
//        print(NetworkConstant.shared.offset)
//        Se já estiver a carregar, não faz nada
        if isLoading.value ?? true {
            return
        }

        isLoading.value = true

        APICaller.getCharactersInfo(offset: offset) { [weak self] characters in
            guard let self = self else { return }
            
            self.isLoading.value = false
            
            // Se a resposta da API for vazia, não faz mais nada
            guard !characters.isEmpty else { return }

            print("Número de personagens carregados: \(characters.count)")

            // Se for a primeira carga, inicializa a lista
            if self.dataSource == nil {
                self.dataSource = characters
            } else {
                self.dataSource?.append(contentsOf: characters)
            }
            self.mapCellData()
        }
        NetworkConstant.shared.offset += NetworkConstant.shared.limit
    }
    
    func mapCellData(){
        guard let dataSource = self.dataSource, !dataSource.isEmpty else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let mappedData = dataSource.map { CharacterTableCellViewModel(character: $0) }
            
            DispatchQueue.main.async {
                self.cellDataSource.value = mappedData
                self.onCharactersUpdated?()
            }
        }
    }

    
    func getCharacterName(_ character: Character) -> String{
        return character.name ?? ""
    }
}
    

