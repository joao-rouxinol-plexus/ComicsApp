//
//  CharacterInformationCollectionViewCell.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit

final class CharacterInformationCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterInformationCollectionViewCell"
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImgView : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.round()
        return view
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.round()
        contentView.addBorder()
        contentView.layer.masksToBounds = true
        contentView.addSubview(valueLabel)
        contentView.addSubview(titleContainerView)
        contentView.addSubview(iconImgView)
        titleContainerView.addSubview(titleLabel)
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains() {
        
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.33),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            valueLabel.trailingAnchor.constraint(equalTo: iconImgView.trailingAnchor,constant: -30),
            valueLabel.heightAnchor.constraint(equalToConstant: 70),
            
            iconImgView.heightAnchor.constraint(equalToConstant: 30),
            iconImgView.widthAnchor.constraint(equalToConstant: 30),
            iconImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            iconImgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -35),
        ])
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImgView.image = nil
        iconImgView.tintColor = .label
        titleLabel.textColor = .label
    }
    
    public func configure(with viewModel: CharacterInformationCollectionViewCellViewModel) {
        
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImgView.image = viewModel.iconImage
        iconImgView.tintColor = viewModel.tintedColor
        titleLabel.textColor = viewModel.tintedColor
    }
}
