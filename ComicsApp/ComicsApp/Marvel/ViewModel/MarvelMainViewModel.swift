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
    
    func getData(){
        
        if isLoading.value ?? true {
            return
        }
        
        isLoading.value = true
        APICaller.getCharactersInfo(){ [weak self] characters in
            self?.isLoading.value = false
            print("Numero de personagens:\(characters.count)")
            self?.dataSource = characters
            self?.mapCellData()
            for character in characters {
                print("\(String(describing: character.name!))")
            }
        }
    }
    
    func mapCellData(){
        self.cellDataSource.value = self.dataSource?.compactMap({CharacterTableCellViewModel(character: $0)})
    }
    
    func getCharacterName(_ character: Character) -> String{
        return character.name ?? ""
    }
    

    
}
    

