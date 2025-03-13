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
    var description: String
    var comics: Int
    var stories: Int
    var series: Int
    var events: Int
    var imageUrl: URL?
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name ?? ""
        self.description = character.description ?? ""
        self.comics = character.comics?.available ?? 0
        self.stories = character.stories.available
        self.series = character.series?.available ?? 0
        self.events = character.events?.available ?? 0
        self.imageUrl = makeImageURL(path: character.thumbnail.path, ext: character.thumbnail.thumbnailExtension.rawValue)
        }

            // Modifique esta função para aceitar o path e o thumbnailExtension diretamente
        private func makeImageURL(path: String, ext: String) -> URL? {
            // Combina o path com a extensão
            let securePath = path.replacingOccurrences(of: "http://", with: "https://")
            print("\(securePath).\(ext)")
            return URL(string: "\(securePath).\(ext)")
            }
}
