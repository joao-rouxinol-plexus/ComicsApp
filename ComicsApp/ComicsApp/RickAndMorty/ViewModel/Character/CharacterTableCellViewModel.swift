//
//  CharacterTableCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 14/3/25.
//

import Foundation
import UIKit

class CharacterTableCellViewModel{
    
    var id : Int
    var status : Status
    var name: String
    var imageURL: URL?
    var location: String
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.status = character.status
        self.location = character.location.name
        self.imageURL = makeImageURL(character.image)
    }
    
    private func makeImageURL(_ imageUrl : String) -> URL?{
        URL(string: imageUrl)
    }
    
    public func stautsColor(status: Status) -> UIColor{
        switch status {
        case .alive:
            return .systemGreen
        case .dead:
            return .systemRed
        case .unknown:
            return .systemGray

        }
    }
}
