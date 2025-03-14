//
//  MainViewModel.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

class PokemonMainViewModel {
    
    var dataSource: PokemonSpecies?
    var isready: Bool = false
    var partComplete: Bool = false
    var next : String?
    var previous : String?
    func getData(_ id: Int){
        PokemonApiCaller.getSpeciesInfo(pokemonID: id) { [weak self] result in
            self?.dataSource = result
            self?.isready = true
        }
    }
    
    
    //MARK - Lista Pokédex
    var listDataSource: [PokemonSpeciesList] = []
    var pokemons: [PokemonSpeciesViewModel]?
    var number = 0
    let pageLimit: Int = 20
    func getList(position : listNav){
        let defaulturl =  "\(PokemonNetworkConstants().speciesURL)?\(PokemonNetworkConstants().limitURL)\(pageLimit)"
        var url = ""
        
        switch position {
        case .previous:
            if self.previous == nil {
                print("prev is nil")
                return
            }
            url = previous ?? defaulturl
            number -= 1
            
        case .next:
            if self.next == nil {
                print("next is nil")
                return
            }
            url = next ?? defaulturl
            number += 1
            
        default:
            url = defaulturl
        }
        
        self.isready = false
        if listDataSource.count <= number {
            
            PokemonApiCaller.listSpecies(urlstring: url){ [weak self] result in
                self?.next = result.next
                self?.previous = result.previous
                self?.listDataSource.append(result)
                self?.mapPokemonData(self!.number)
                self?.isready = true
            }
            
        }
        
        
        else {
            self.next = listDataSource[number].next
            self.previous = listDataSource[number].previous
            self.mapPokemonData(number)
            self.isready = true
        }
    }
    
    func numberOfRows() -> Int {
        return pokemons?.count ?? 0
    }
    
    private func mapPokemonData(_ number: Int) {
        pokemons = self.listDataSource[number].results.compactMap({PokemonSpeciesViewModel($0)})
        pokemons?.removeAll(where: { $0.id > 9000 })
        if pokemons?.count ?? 20 < pageLimit {
            self.next = nil
        }
    }
}




