//
//  CharacterEpisodesCollectionViewCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import Foundation

final class CharacterEpisodesCollectionViewCellViewModel {
    
    private let episodeURL : URL?
    
    init(episodeURL : URL?){
        self.episodeURL = episodeURL
        
    }
    private var episodeURLString : String? {
        guard let episodeURL = episodeURL else { return nil }
        return String(describing: episodeURL)
    }
    
    func getEpisodeData(){
        APICaller.getEpisodes(from: episodeURLString ?? "") { result in
            switch result {
            case .success(let episodeData):
                print(episodeData)
            case .failure(let error):
                print(error)
            }
        }
    }
}


