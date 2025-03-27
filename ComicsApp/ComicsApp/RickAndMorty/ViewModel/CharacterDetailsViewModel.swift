//
//  CharacterDetailsViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import Foundation

class CharacterDetailsViewModel {
    
    var character: Character
    
    var characterName: String
    var characterStatus: Status
    var characterImgUrl: URL?
    
    
    init(character: Character) {
        self.character = character
        self.characterName = character.name
        self.characterStatus = character.status
        self.characterImgUrl = makeImageURL(character.image)
    }
    
    private func makeImageURL(_ image: String?) -> URL? {
        guard let imageUrlString = image else { return nil }
        return URL(string: imageUrlString)
    }
}
