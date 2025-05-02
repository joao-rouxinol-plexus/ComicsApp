//
//  CharacterEpisodesCollectionViewCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import Foundation

final class CharacterEpisodesCollectionViewCellViewModel {
    
    private let episodeString : String
    public var episodeData : EpisodesModel?
    
    init(episodeURL : String) {
        
        self.episodeString = episodeURL
        getEpisodeData(episodeURLString: episodeString)
        
    }
    
    private func getEpisodeData(episodeURLString : String) {
        
        APICaller.getEpisodes(from: episodeURLString) { result in
            
            switch result {
                
            case .success(let episodeData):
                self.episodeData = episodeData
                self.splitString(string: episodeData.episode)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func splitString(string: String) {
        
        let newString = string.replacingOccurrences(of: "S" , with: "Season: ")
            .replacingOccurrences(of: "E" , with: " Episode: ")
        episodeData?.episode = newString
    }
}
