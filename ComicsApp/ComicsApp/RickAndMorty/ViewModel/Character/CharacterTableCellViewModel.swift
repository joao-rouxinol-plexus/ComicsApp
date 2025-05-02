//
//  CharacterTableCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 14/3/25.
//

import Foundation

class CharacterTableCellViewModel{
    
    var id: Int
    var name: String
    var imageURL: URL?
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.imageURL = makeImageURL(character.image)
    }
    
    private func makeImageURL(_ imageUrl : String) -> URL?{
        URL(string: imageUrl)
    }
}
