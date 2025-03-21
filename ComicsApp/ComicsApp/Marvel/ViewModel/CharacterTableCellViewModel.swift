//
//  CharacterTableCellViewModel.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 11/03/2025.
//

import Foundation

class CharacterTableCellViewModel{
    var id: Int
    var name: String
    
    var comics: Int
    var stories: Int
    var series: Int
    var events: Int
    var description: String
    var imageUrl: URL?
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name ?? ""
        self.comics = character.comics?.available ?? 0
        self.stories = character.stories.available
        self.series = character.series?.available ?? 0
        self.events = character.events?.available ?? 0
        self.description = (character.description?.isEmpty ?? true) ? "No details available" : character.description!
        self.imageUrl = makeImageURL(path: character.thumbnail.path, ext: character.thumbnail.thumbnailExtension.rawValue)
    }

    private func makeImageURL(path: String, ext: String) -> URL? {
        let securePath = path.replacingOccurrences(of: "http://", with: "https://")
        print("\(securePath).\(ext)")
            return URL(string: "\(securePath).\(ext)")
    }
}
