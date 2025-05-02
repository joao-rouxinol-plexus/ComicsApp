//
//  Untitled.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 26/4/25.
//

import UIKit

// MARK: - CollectionView

extension CharactersDetailsController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType{
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
            
        case .photo(let viewModel):
            
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath)
                    as? CharacterPhotoCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModel)
            return cell
            
        case .information(let viewModels):
            
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInformationCollectionViewCell.cellIdentifier, for: indexPath)
                    as? CharacterInformationCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            return cell
            
        case .episodes(let viewModels):
            
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodesCollectionViewCell.cellIdentifier, for: indexPath)
                    as? CharacterEpisodesCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
