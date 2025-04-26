//
//  Rick_MortyMainViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 13/3/25.
//

import Foundation

class RickMortyMainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource : Observable<[CharacterTableCellViewModel]> = Observable(nil)
    private var characters : [Character] = []
    private var visibleCharactersCount = 10
    public var nextPageUrl : String?
    
    func numOfSections() -> Int {
        return 1
    }
    
    func numOfRows(inSection section: Int) -> Int {
        return characters.count
    }
    
    func getCellViewModel(at indexPath : IndexPath ) -> CharacterTableCellViewModel? {
        return cellDataSource.value?[indexPath.row]
    }
    
    func refreshData() {
        
        characters.removeAll()
        cellDataSource.value = nil
        visibleCharactersCount = 10
        getData()
        
    }
    
    func getData() {
        
        if isLoading.value ?? false {
            return
        }
        
        isLoading.value = true
        
        APICaller.getCharacters(from: NetworkConstant.shared.serverURL.appending(NetworkConstant.shared.charactersURL)) { [weak self] result in
            
            self?.isLoading.value = false
            
            switch result {
                
            case .success(let newCharacters):
                
                self?.characters = newCharacters.results
                self?.mapCellData()
                self?.nextPageUrl = newCharacters.info.next
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mapCellData() {
        
        self.cellDataSource.value = characters.compactMap{CharacterTableCellViewModel(character: $0)}
    }
    
    func loadMoreCharacters() {
        
        guard let nextPageUrl = self.nextPageUrl, !isLoading.value! else {
            return
        }
        
        isLoading.value = true
        
        guard visibleCharactersCount < characters.count else {
            return
        }
        
        APICaller.getCharacters(from: nextPageUrl) { [weak self] result in
            
            guard let self = self else { return }
            
            self.isLoading.value = false
            
            switch result {
                
            case .success(let newCharacters):
                
                self.characters.append(contentsOf: newCharacters.results)
                self.nextPageUrl = newCharacters.info.next
                
                DispatchQueue.main.async {
                    self.mapCellData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func retrieveCharacter(whit id: Int) -> Character? {
        
        guard let character = characters.first(where: {$0.id == id}) else {
            return nil
        }
        
        return character
    }
}
