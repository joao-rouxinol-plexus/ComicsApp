//
//  PokemonMainViewModel.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 28/02/2025.
//

import Foundation

class PokemonMainViewModel {
    
    var next : String?
    var previous : String?
    
    
    var cachedTypesArray = [PokemonTypeViewModel?]()
    
    func getPokemonTypeData(_ url: String) -> PokemonTypeViewModel?{
        let id = Int((url.split(separator: "/").last!))!
        
        if let cachedTypes = cachedTypesArray[id-1] {
            print("returning type \(id)")
            return cachedTypes
        }
        print("getting type \(id)")
        
        var typeIsReady = false
        
        PokemonApiCaller.getTypeInfo(urlString: url) { [weak self] typeresult in
            self?.cachedTypesArray[id-1] = PokemonTypeViewModel(type: typeresult)
            typeIsReady = true
        }
        
        while (!typeIsReady) {
            _ = wait()
        }
        
        return self.cachedTypesArray[id-1]
    }
    
    var cachedPokemonArray = [PokemonViewModel?]()
    
    func getPokemonData(_ url: String) -> PokemonViewModel?{
        
        let id = Int((url.split(separator: "/").last!))!
        
        if let cachedPokemon = cachedPokemonArray[id-1] {
            print("returning \(id)")
            return cachedPokemon
        }
        
        var pokemonIsReady = false
        
        print("getting \(id)")
        PokemonApiCaller.getPokemonInfo(urlString: url) { [weak self] pokemonResult in
            self?.cachedPokemonArray[id-1] = PokemonViewModel(pokemon: pokemonResult)
            pokemonIsReady = true
        }
        
        while (!pokemonIsReady) {
            _ = wait()
        }
        
        return self.cachedPokemonArray[id-1]
        
    }
    
    
    //MARK - Lista Pokédex
    var listDataSource: [PokemonList] = []
    var pokemons: [PokemonListViewModel] = []
    var currentList = 0
    let pageLimit: Int = 20
    
    
    var first = true
    func loadList(url: String, list:Int){
        
        var listReady = false
        
        if listDataSource.count < list+1 {
            PokemonApiCaller.listSpecies(urlstring: url){ [weak self] listResult in
                self?.listDataSource.append(listResult)
                listReady = true
                print("loaded list \(url)")
            }
        }
        
        while listReady != true {
            _ = wait()
        }
        
        if first {
            cachedPokemonArray = Array<PokemonViewModel?>(repeating: nil, count: listDataSource[0].count)
            first = false
        }
        
        let group = DispatchGroup()
        
        for i in listDataSource[list].results.indices {
            
            let pokeURL = listDataSource[list].results[i].url
            
            let id = Int((pokeURL.split(separator: "/").last!))!
            if (id < 9500){
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    _ = self.getPokemonData(pokeURL)
                    group.leave()
                }
            }
        }
    }
    
    func getList(position : listNav, closure: (() -> Void)? = nil) {
        
        let defaulturl = "\(PokemonNetworkConstants().pokemonURL)?\(PokemonNetworkConstants().limitURL)\(pageLimit)"
        var url = ""
        
        switch position {
        case .previous:
            if previous == nil {return}
            url = listDataSource[currentList].previous ?? defaulturl
            currentList -= 1
            
        case .next:
            if next == nil {return}
            url = listDataSource[currentList].next ?? defaulturl
            currentList += 1
            
        default:
            url = defaulturl
        }
        
        if listDataSource.count <= currentList {
            loadList(url: url, list: currentList)
        }

        previous = listDataSource[currentList].previous
        next = listDataSource[currentList].next
        
        let nextPage = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated).async {
            nextPage.enter()
            if let nexturl = self.listDataSource[self.currentList].next {
                self.loadList(url: nexturl, list: self.currentList+1)
            }
            nextPage.leave()
        }
        
        
        for i in listDataSource[currentList].results.indices {
            let id = Int((listDataSource[currentList].results[i].url.split(separator: "/").last!))!
            if (id < 9500){
                mapPokemonData(self.getPokemonData(listDataSource[currentList].results[i].url)!)
            }
            else{
                next = nil
            }
        }
        
        closure?()
    }
    
    func numberOfRows() -> Int {
        return pokemons.count
    }
    
    private func mapPokemonData(_ pokemon : PokemonViewModel) {
        pokemons.append(PokemonListViewModel(pokemon))
    }
}

