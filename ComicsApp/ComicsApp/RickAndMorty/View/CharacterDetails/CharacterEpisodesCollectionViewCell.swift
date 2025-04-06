//
//  CharacterEpisodesCollectionViewCell.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit

final class CharacterEpisodesCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterEpisodesCollectionViewCell"
    
    
    private let episodeNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let episodeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private let airDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    //    MARK: - Init

    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.round()
        contentView.addBorder(color: .systemGray, width: 1.0)
        contentView.addSubview(episodeNameLabel)
        contentView.addSubview(episodeLabel)
        contentView.addSubview(airDateLabel)
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains(){
        NSLayoutConstraint.activate([
            episodeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            episodeNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            episodeNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            episodeLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 20),
            episodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            episodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            airDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            airDateLabel.heightAnchor.constraint(equalToConstant: 20),

            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeLabel.text = nil
        episodeNameLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configure(with viewModel: CharacterEpisodesCollectionViewCellViewModel){
        episodeLabel.text = "S01E01"
        episodeNameLabel.text = "Pilot"
        airDateLabel.text = "December 2, 2013"
    }
    
}
