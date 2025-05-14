//
//  CharacterEpisodesCollectionViewCell.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit

final class CharacterEpisodesCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CharacterEpisodesCollectionViewCell"
    
    private let headerLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.round()
        label.backgroundColor = .secondarySystemBackground
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .systemMint
        return label
    }()
    
    private let episodeNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font =  UIFont.preferredFont(for: .body, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let episodeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let airDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.round()
        contentView.addBorder()
        setUpConstrains()
        setUpAcessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains() {
        
        let stackView = UIStackView(arrangedSubviews: [episodeNameLabel,episodeLabel,airDateLabel])
        let mainStackView = UIStackView(arrangedSubviews: [headerLabel,stackView])
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 5
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor,constant: 2),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 2),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -2),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        episodeLabel.text = nil
        episodeNameLabel.text = nil
        airDateLabel.text = nil
        headerLabel.text = nil
    }
    
    public func configure(with viewModel: CharacterEpisodesCollectionViewCellViewModel) {
        
        episodeLabel.text = viewModel.episodeData?.episode
        episodeNameLabel.text = viewModel.episodeData?.name
        airDateLabel.text = viewModel.episodeData?.airDate
        headerLabel.text = "EPISODE DETAILS"
    }
        
        private func setUpAcessibility() {
            
            episodeNameLabel.isAccessibilityElement = true
            episodeNameLabel.accessibilityHint = "Episode name"
            
            episodeLabel.isAccessibilityElement = true
            episodeLabel.accessibilityHint = "Episode season and number"
            
            airDateLabel.isAccessibilityElement = true
            airDateLabel.accessibilityHint = "Air date of the episode"
            
            
        }
}
