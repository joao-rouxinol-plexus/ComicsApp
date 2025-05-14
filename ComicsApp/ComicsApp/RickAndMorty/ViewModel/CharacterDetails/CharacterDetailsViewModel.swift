//
//  CharacterDetailsViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit

class CharacterDetailsViewModel {
    
    private let character: Character
    
    private let textSize = UIApplication.shared.preferredContentSizeCategory >= .accessibilityMedium
    
    public var getCharacterName: String {
        return character.name
    }
    
    enum SectionType {
        
        case photo(viewModel: CharacterPhotoCollectionViewCellViewModel)
        
        case information(viewModel: [CharacterInformationCollectionViewCellViewModel])
        
        case episodes(viewModel: [CharacterEpisodesCollectionViewCellViewModel])
    }
    
    public var sections : [SectionType] = []
    
    // MARK: - Init
    
    init(character: Character) {
        self.character = character
        setUpSections()
    }
    
    // MARK: - Sections Setup
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModel: [
                .init(value: character.status.rawValue, type: .status),
                .init(value: character.gender.rawValue, type: .gender),
                .init(value: character.species, type: .species),
                .init(value: character.origin.name, type: .origin),
            ]),
            .episodes(viewModel: character.episode.compactMap({
                return CharacterEpisodesCollectionViewCellViewModel(episodeURL: $0)
            }))
        ]
    }
    
    // MARK: - Layouts
    
    func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
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
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                               heightDimension: .estimated(100)
                                                                              ),
                                                       subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
    func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(100))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                                               heightDimension: .estimated(100)
                                                                              ),
                                                       subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return section
    }
    
}
