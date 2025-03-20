
//    var pokemonDataSource: [String: Pokemon] = [:]

//    func getPokemonDataDICTIONARY(_ url: String) -> Pokemon?{
//        var pokemonIsReady: Bool = false
//
//        pokemonIsReady = false
//        if !pokemonDataSource.keys.contains(url){
//            print("getting \(url.split(separator: "/").last!)")
//
//            PokemonApiCaller.getPokemonInfo(urlString: url) { [weak self] pokemonResult in
//                self?.pokemonDataSource[url] = pokemonResult
//                pokemonIsReady = true
//            }
//
//        }
//
//        else {
//            print("returning \(url.split(separator: "/").last!)")
//            pokemonIsReady = true
//        }
//        while !pokemonIsReady {
//            _ = wait()
//        }
//        //        var pokemonToReturn : Pokemon?
//        //        DispatchQueue.main.async { [weak self] in
//        //            guard let self = self else { return }
//        //            pokemonToReturn = pokemonDataSource[url]
//        //            print("now ready \(url.split(separator: "/").last!)")
//        //        }
//        //
//        //
//        //        print("now returning \(url.split(separator: "/").last!)")
//        //        return pokemonToReturn
//
//        return self.pokemonDataSource[url]
//    }

//    var pokeArrayTest = Array<PokemonViewModel?>(repeating: nil, count: 1000)





////
////  PokemonMainViewModel.swift
////  testeapipokemon
////
////  Created by Duarte Miguel Charrua Silva on 28/02/2025.
////
//
//import Foundation
//
//class __PokemonMainViewModel {    
//    var PokemonDataSource: [Pokemon] = []
//    var pokemonIsReady: Bool = false
//    var partComplete: Bool = false
//    var next : String?
//    var previous : String?
//    
//    func getPokemonData(_ url: String, _ id : Int) -> Pokemon?{
//        self.pokemonIsReady = false
//        if PokemonDataSource.count <= id {
//            print("getting \(id)")
//            
//            PokemonApiCaller.getPokemonInfo(urlString: url) { [weak self] pokemonResult in
//                self?.PokemonDataSource.append(pokemonResult)
//                self?.pokemonIsReady = true
//            }
//        }
//        
//        else {
//            print("returning \(id)")
//            self.pokemonIsReady = true
//        }
//        while !self.pokemonIsReady {
//            _ = wait()
//        }
//        return self.PokemonDataSource[id]
//    }
//    
//    
//    //MARK - Lista Pokédex
//    var listDataSource: [PokemonList] = []
//    var pokemons: [PokemonListViewModel] = []
//    var number = 0
//    let pageLimit: Int = 2000
//    var isready: Bool = false
//    func getList(position : listNav){
//        self.partComplete = false
//        
//        let defaulturl =  "\(PokemonNetworkConstants().pokemonURL)?\(PokemonNetworkConstants().limitURL)\(pageLimit)"
//        var url = ""
//        
//        switch position {
//        case .previous:
//            if self.previous == nil {return}
//            url = previous ?? defaulturl
//            number -= 1
//            
//        case .next:
//            if self.next == nil {return}
//            url = next ?? defaulturl
//            number += 1
//            
//        default:
//            url = defaulturl
//        }
//        
//        self.isready = false
//        if listDataSource.count <= number {
//            
//            PokemonApiCaller.listSpecies(urlstring: url){ [weak self] listResult in
//                self?.next = listResult.next
//                self?.previous = listResult.previous
//                self?.listDataSource.append(listResult)
//                self?.partComplete = true
//            }
//        }
//        
//        else {
//            self.next = listDataSource[number].next
//            self.previous = listDataSource[number].previous
//            self.partComplete = true
//        }
//        
//        while self.partComplete != true {
//            _ = wait()
//        }
//        pokemons.removeAll()
//        
//        for i in listDataSource[number].results.indices {
//            //            print("mapping \(self.getPokemonData(listDataSource[number].results[i].url, (number*pageLimit + i))!)")
//            mapPokemonData(self.getPokemonData(listDataSource[number].results[i].url, (number*pageLimit + i))!)
//            
//            
//            while self.pokemonIsReady != true {
//                exit(10)
//            }
//            
//        }
//        
//        self.isready = true
//    }
//    
//    func numberOfRows() -> Int {
//        return pokemons.count
//    }
//    
//    private func mapPokemonData(_ pokemon : Pokemon) {
//        
//        if pokemon.id < 9500 {
//            pokemons.append(PokemonListViewModel(PokemonViewModelWithShinyProperty(pokemon: pokemon)))
//        }
//        else {
//            self.next = nil
//        }
//        
//        
//        
//        
//    }
//    
//    
//    
//    
//}
