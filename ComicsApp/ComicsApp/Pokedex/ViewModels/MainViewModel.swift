//
//  MainViewModel.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation


class MainViewModel {
    
    var dataSource: PokemonSpecies?
    var isready: Bool = false
    func getData(_ id: Int){
        ApiCaller.getSpeciesInfo(pokemonID: id) { [weak self] result in
            print("result:")
            print(result)
            self?.dataSource = result
            self?.isready = true
        }
    }
    
    
    // MARK - Lista Pokédex
    var listDataSource: SpeciesList?
    var pokemons: [SpeciesViewModel]?
    func getList(){
        ApiCaller.listSpecies(){ [weak self] result in
            //            print("result:")
            //            print(result)
            self?.listDataSource = result
            self?.mapPokemonData()
            self?.isready = true
        }
    }
    
    func numberOfRows() -> Int {
        print(listDataSource?.count ?? 0)
        return listDataSource?.count ?? 0
    }
    
//    func printthemons(){
//        for p in self.pokemons ?? [] {
//            print(p.pokemon.padding(toLength: 12, withPad: " ", startingAt: 0))
//            print(p.imageURL)
//            
//        }
//    }
    
    private func mapPokemonData() {
        pokemons = self.listDataSource?.results.compactMap({SpeciesViewModel($0)})
    }
}


