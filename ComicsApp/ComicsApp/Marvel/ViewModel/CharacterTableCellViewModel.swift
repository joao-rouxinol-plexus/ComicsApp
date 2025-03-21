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
    var comics: [String]
    var stories: [String]
    var series: [String]
    var events: [String]
    var description: String
    var imageUrl: URL?
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name ?? ""
        
        self.comics = character.comics?.items.map { $0.name } ?? []
        if self.comics.isEmpty { self.comics = ["No comics available"] }

        self.stories = character.stories.items.map { $0.name }
        if self.stories.isEmpty { self.stories = ["No stories available"] }

        self.series = character.series?.items.map { $0.name } ?? []
        if self.series.isEmpty { self.series = ["No series available"] }

        self.events = character.events?.items.map { $0.name } ?? []
        if self.events.isEmpty { self.events = ["No events available"] }
        self.description = (character.description?.isEmpty ?? true) ? "No details available" : character.description!
        self.imageUrl = makeImageURL(path: character.thumbnail.path, ext: character.thumbnail.thumbnailExtension.rawValue)
    }

    private func makeImageURL(path: String, ext: String) -> URL? {
        let securePath = path.replacingOccurrences(of: "http://", with: "https://")
        print("\(securePath).\(ext)")
            return URL(string: "\(securePath).\(ext)")
    }
}
