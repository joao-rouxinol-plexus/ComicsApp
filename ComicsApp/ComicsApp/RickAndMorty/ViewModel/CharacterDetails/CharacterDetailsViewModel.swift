//
//  CharacterDetailsViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit

class CharacterDetailsViewModel {
    
    var character: Character
    
    var characterName: String
    var characterStatus: Status
    var characterImgUrl: URL?
    
    enum SectionType : CaseIterable{
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionType.allCases
    
    // MARK: - Init
    
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
    
//    MARKS: - Layouts
    
     func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                               heightDimension: .fractionalHeight(0.5)
                                                                              ),
                                                     subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
     func createInformationSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                               heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                               heightDimension: .absolute(150)
                                                                              ),
                                                     subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
     func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                                               heightDimension: .absolute(150)
                                                                              ),
                                                     subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
