//
//  CharacterPhotoCollectionViewCell.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 28/3/25.
//

import UIKit
import SDWebImage

final class CharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstrains()
        setUpAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstrains(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(with viewModel: CharacterPhotoCollectionViewCellViewModel){
        imageView.sd_setImage(with: viewModel.getImageURL())
    }
    
    private func setUpAccessibility() {
        imageView.isAccessibilityElement = true
        imageView.accessibilityHint = "Image of character"
    }
}
