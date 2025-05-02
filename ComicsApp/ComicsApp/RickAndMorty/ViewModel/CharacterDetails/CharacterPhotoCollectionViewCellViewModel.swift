//
//  CharacterPhotoCollectionViewCellViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import Foundation
import SDWebImage

final class CharacterPhotoCollectionViewCellViewModel {
    
    private let imageURL: URL?
    
    init(imageUrl: URL?) {
        self.imageURL = imageUrl
    }
    
    func getImageURL() -> URL? {
        return imageURL
    }
}
