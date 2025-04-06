//
//  DetailsCharactersController.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit
import SDWebImage

class CharactersDetailsController: UIViewController {
    
    private let viewModel : CharacterDetailsViewModel
    private let detailView: CharacterDetailView
    
    //    MARK: - Inits
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        self.detailView = CharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = viewModel.getCharacterName
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        view.addSubview(detailView)
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
}

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
        
        switch sectionType{
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
