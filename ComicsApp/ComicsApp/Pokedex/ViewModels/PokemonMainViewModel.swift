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
    
    var pokeArrayTest = [PokemonViewModel?]()
    
    func getPokemonData(_ url: String) -> PokemonViewModel?{
        var pokemonIsReady = false
        
        let id = Int((url.split(separator: "/").last!))!
        
        
        print("index \(id-1)")
        if (id < 9500 && pokeArrayTest[id-1] == nil) {
            print("getting \(id)")
            PokemonApiCaller.getPokemonInfo(urlString: url) { [weak self] pokemonResult in
                self?.pokeArrayTest[id-1] = PokemonViewModel(pokemon: pokemonResult)
                pokemonIsReady = true
            }
        }
        
        else {
            print("returning \(id)")
            pokemonIsReady = true
        }
        while (!pokemonIsReady) {
            _ = wait()
        }
        return self.pokeArrayTest[id-1]
    }
    
    
    //MARK - Lista Pokédex
    var listDataSource: [Int: PokemonList] = [:]
    var pokemons: [PokemonListViewModel] = []
    var currentList = 0
    let pageLimit: Int = 20
    var isready: Bool = false
    var threeDoubles = [Pokemon?]()
    
    
    var first = true
    func loadList(url: String, list:Int){
        
        print("counts \(pokeArrayTest.count) ")
        var partComplete = false
        
        PokemonApiCaller.listSpecies(urlstring: url){ [weak self] listResult in
            self?.listDataSource[list] = listResult
            partComplete = true
            print("loaded list \(url)")
        }
        
        while partComplete != true {
            _ = wait()
        }
        
        if first {
            pokeArrayTest = Array<PokemonViewModel?>(repeating: nil, count: listDataSource[0]?.count ?? 0)
            first = false
        }
        
        let group = DispatchGroup()
        
        for i in listDataSource[list]!.results.indices {
            
            let pokeURL = listDataSource[list]!.results[i].url
            
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
        
        
        let defaulturl =  "\(PokemonNetworkConstants().pokemonURL)?\(PokemonNetworkConstants().limitURL)\(pageLimit)"
        var url = ""
        
        switch position {
        case .previous:
            if listDataSource[currentList]!.previous == nil {return}
            url = listDataSource[currentList]!.previous ?? defaulturl
            currentList -= 1
            
        case .next:
            //            if self.listDataSource[currentList] == nil {
            //                print("currentlist nulll????")
            //                return}
            if self.listDataSource[currentList]!.next == nil {return}
            url = listDataSource[currentList]!.next ?? defaulturl
            currentList += 1
            
        default:
            url = defaulturl
        }
        
        self.isready = false
        
        if listDataSource.count <= currentList {
            loadList(url: url, list: currentList)
            previous = listDataSource[currentList]!.previous
            next = listDataSource[currentList]!.next
        }
        
        else {
            self.next = listDataSource[currentList]!.next
            self.previous = listDataSource[currentList]!.previous
        }
        
        let nextPage = DispatchGroup()
        DispatchQueue.global(qos: .userInitiated).async {
            nextPage.enter()
            if let nexturl = self.listDataSource[self.currentList]?.next {
                print("loading next list?")
                self.loadList(url: nexturl, list: self.currentList+1)
            }
            nextPage.leave()
        }
        
        
        
        //        pokemons.removeAll()
        
        for i in listDataSource[currentList]!.results.indices {
            let id = Int((listDataSource[currentList]!.results[i].url.split(separator: "/").last!))!
            if (id < 9500){
                mapPokemonData(self.getPokemonData(listDataSource[currentList]!.results[i].url)!)
            }
            else{
                next = nil
            }
        }
        self.isready = true
        
        closure?()
    }
    
    func numberOfRows() -> Int {
        return pokemons.count
    }
    
    private func mapPokemonData(_ pokemon : PokemonViewModel) {
        if pokemon.id < 9500 {
            pokemons.append(PokemonListViewModel(pokemon))
        }
        else {
            self.listDataSource[currentList]?.next = nil
            self.next = nil
        }
    }
}

