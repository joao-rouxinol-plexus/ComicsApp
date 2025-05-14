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
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.backgroundColor = .secondarySystemBackground
        label.round()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let iconImgView : UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.round()
        contentView.addBorder()
        contentView.layer.masksToBounds = true
        setUpConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains() {
        // Container para a imagem, com tamanho fixo
        let iconContainerView = UIView()
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.addSubview(iconImgView)

        NSLayoutConstraint.activate([
            iconImgView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImgView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImgView.widthAnchor.constraint(equalToConstant: 40),
            iconImgView.heightAnchor.constraint(equalToConstant: 40),
            iconContainerView.widthAnchor.constraint(equalToConstant: 50),
            iconContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Stack interno (valor + ícone)
        let stackView = UIStackView(arrangedSubviews: [valueLabel, iconContainerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Stack principal (título + stack interno)
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, stackView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.spacing = 2
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
