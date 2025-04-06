//
//  CharacterDetailView.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit

//View for single characrter info
final class CharacterDetailView: UIView {
    
    public  var collectionView : UICollectionView?
    
    private let viewModel: CharacterDetailsViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //    MARK: - Init
    init(frame: CGRect, viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame:frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(collectionView)
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsuported")
    }
    
    private func addConstraints(){
        guard let collectionView = collectionView else { return }
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterInformationCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInformationCollectionViewCell.cellIdentifier)
        collectionView.register(CharacterEpisodesCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodesCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex]{
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return  viewModel.createInformationSectionLayout()
        case .episodes:
            return viewModel.createEpisodesSectionLayout()
        }
    }
}
