//
//  CharacterDetailsViewModel.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit

class CharacterDetailsViewModel {
    
    private let character: Character
    
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
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModel: [
                .init(value: character.status.rawValue, type: .status),
                .init(value: character.gender.rawValue, type: .gender),
                .init(value: character.species, type: .species),
                .init(value: character.origin.name, type: .origin),
                .init(value: character.location.name, type: .location),
                .init(value: "\(character.episode.count)", type: .episodeCount)
            ]),
            .episodes(viewModel: character.episode.compactMap({
                return CharacterEpisodesCollectionViewCellViewModel(episodeURL: URL(string: $0))
            }))
        ]
        
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
    
    public var getCharacterName: String {
            return character.name
        }
}
