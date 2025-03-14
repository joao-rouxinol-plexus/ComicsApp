//
//  PokemonMainViewModel.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

class PokemonMainViewModel {
    
    var PokemonDataSource: [String: Pokemon] = [:]
    var partComplete: Bool = false
    //    var next : String?
    //    var previous : String?
    
    func getPokemonData(_ url: String) -> Pokemon?{
        var pokemonIsReady: Bool = false
        
        pokemonIsReady = false
        if !PokemonDataSource.keys.contains(url){
            print("getting \(url.split(separator: "/").last!)")
            
            PokemonApiCaller.getPokemonInfo(urlString: url) { [weak self] pokemonResult in
                self?.PokemonDataSource[url] = pokemonResult
                pokemonIsReady = true
            }
        }
        
        else {
            print("returning \(url.split(separator: "/").last!)")
            pokemonIsReady = true
        }
        while !pokemonIsReady {
            _ = wait()
        }
        //        print("\(url.split(separator: "/").last!) is ready")
        return self.PokemonDataSource[url]
    }
    
    
    //MARK - Lista Pokédex
    var listDataSource: [PokemonList] = []
    var pokemons: [PokemonListViewModel] = []
    var number = 0
    let pageLimit: Int = 20
    var isready: Bool = false
    
    func loadList(url: String){
        PokemonApiCaller.listSpecies(urlstring: url){ [weak self] listResult in
            //            self?.next = listResult.next
            //            self?.previous = listResult.previous
            self?.listDataSource.append(listResult)
            self?.partComplete = true
            print("loaded list \(url)")
        }
        while self.partComplete != true {
            _ = wait()
        }
        
        
        
        let group = DispatchGroup()
        
        //            for i in 0...listDataSource[number].count {
        for i in listDataSource[number].results.indices {
            //                let url = "https://pokeapi.co/api/v2/pokemon/\(i)/"
            let url = listDataSource[number].results[i].url
            group.enter()
            
            DispatchQueue.global(qos: .userInitiated).async {
                _ = self.getPokemonData(url)
                group.leave()
            }
        }
    }
    
    
    func getList(position : listNav){
        
        self.partComplete = false
        
        let defaulturl =  "\(PokemonNetworkConstants().pokemonURL)?\(PokemonNetworkConstants().limitURL)\(pageLimit)"
        var url = ""
        
        switch position {
        case .previous:
            if listDataSource[number].previous == nil {return}
            url = listDataSource[number].previous ?? defaulturl
            number -= 1
            
        case .next:
            if self.listDataSource[number].next == nil {return}
            url = listDataSource[number].next ?? defaulturl
            number += 1
            
        default:
            url = defaulturl
        }
        
        self.isready = false
        if listDataSource.count <= number {
            
            loadList(url: url)
            
            
            if let nexturl = listDataSource[number].next {
                print("loading next list?")
                loadList(url: nexturl)
                
            }
        }
        
        else {
            //            self.next = listDataSource[number].next
            //            self.previous = listDataSource[number].previous
            self.partComplete = true
            
            while self.partComplete != true {
                _ = wait()
            }
            
        }
        
        pokemons.removeAll()
        
        //        group.notify(queue: .main) {
        //            print("group ready")
        //            self.isready = true
        //        }
        
        
        for i in listDataSource[number].results.indices {
            mapPokemonData(self.getPokemonData(listDataSource[number].results[i].url)!)
        }
        
        self.isready = true
    }
    
    func numberOfRows() -> Int {
        return pokemons.count
    }
    
    private func mapPokemonData(_ pokemon : Pokemon) {
        
        if pokemon.id < 9500 {
            pokemons.append(PokemonListViewModel(pokemon))
        }
        else {
            self.listDataSource[number].next = nil
        }
        
        
        
        
    }
    
    
    
    
}
