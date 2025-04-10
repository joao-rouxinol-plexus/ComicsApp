//
//  CharacterEpisodesCollectionViewCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import Foundation

final class CharacterEpisodesCollectionViewCellViewModel {
    
    private let episodeURL : URL?
    public var episodeData : EpisodesModel?
    
    init(episodeURL : URL?){
        self.episodeURL = episodeURL
        getEpisodeData(episodeURLString: episodeURL?.absoluteString ?? "")
        
    }
    
    func getEpisodeData(episodeURLString : String){
        APICaller.getEpisodes(from: episodeURLString) { result in
            switch result {
            case .success(let episodeData):
                self.episodeData = episodeData
            case .failure(let error):
                print(error)
            }
        }
    }
}


