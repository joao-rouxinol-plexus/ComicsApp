//
//  MarvelMainCharacterCell.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 17/04/2025.
//

import UIKit
import SDWebImage

class MarvelMainCharacterCell: UITableViewCell {
    
    // MARK: - Identifier & Registration
    public static var identifier: String {
        return "MarvelMainCharacterCell"
    }
    
    // MARK: - Views
    private var backView: UIView!
    private var characterImageView: UIImageView!
    private var nameLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var comicsLabel: UILabel!
    private var storiesLabel: UILabel!
    private var seriesLabel: UILabel!
    private var eventsLabel: UILabel!
    
    // MARK: - Stack Views
    private var characterStackView: UIStackView!
    private var detailStackView: UIStackView!
    private var detailsTopRow: UIStackView!
    private var detailsBottomRow: UIStackView!
    private var finalStackView: UIStackView!
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func register(with tableView: UITableView) {
        tableView.register(MarvelMainCharacterCell.self, forCellReuseIdentifier: MarvelMainCharacterCell.identifier)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        backView = UIView()
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        backView.layer.borderWidth = 2
        backView.layer.borderColor = UIColor.systemYellow.cgColor
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .boxBackgroundColor
        self.contentView.backgroundColor = .backgroundColor
        
        characterImageView = UIImageView()
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.borderWidth = 2
        characterImageView.layer.borderColor = UIColor.systemYellow.cgColor
        characterImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: 100),
            characterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        if let impactFont = UIFont(name: "Impact", size: 17) {
            nameLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: impactFont)
        }
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.textColor = .systemYellow
        nameLabel.numberOfLines = 0
        
        descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.systemFont(ofSize: 13))
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .textColor
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        comicsLabel = createLabel()
        storiesLabel = createLabel()
        seriesLabel = createLabel()
        eventsLabel = createLabel()
        
        detailsTopRow = UIStackView(arrangedSubviews: [seriesLabel, eventsLabel])
        detailsTopRow.axis = .horizontal
        detailsTopRow.spacing = 8
        detailsTopRow.distribution = .fillEqually
        
        detailsBottomRow = UIStackView(arrangedSubviews: [storiesLabel, comicsLabel])
        detailsBottomRow.axis = .horizontal
        detailsBottomRow.spacing = 8
        detailsBottomRow.distribution = .fillEqually
        
        detailStackView = UIStackView(arrangedSubviews:[ nameLabel,descriptionLabel, detailsTopRow, detailsBottomRow] )
        detailStackView.axis = .vertical
        detailStackView.spacing = 8
        detailStackView.alignment = .fill
        detailStackView.distribution = .fill
        
        finalStackView = UIStackView(arrangedSubviews: [characterImageView, detailStackView])
        finalStackView.translatesAutoresizingMaskIntoConstraints = false
        finalStackView.axis = .vertical
        finalStackView.spacing = 8
        finalStackView.alignment = .center
        
        backView.addSubview(finalStackView)
        
        self.accessibilityElements = [contentView].compactMap { $0 }
        contentView.accessibilityLabel = "Character Cell"
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: UIFont.systemFont(ofSize: 13))
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .textColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            finalStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 8),
            finalStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8),
            finalStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 8),
            finalStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: - Cell Configuration
    func setUpCell(viewModel: MarvelCharacterViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        comicsLabel.attributedText = applyImpactFont(to: "Comics: \(viewModel.comics.count)", for: "Comics:")
        storiesLabel.attributedText = applyImpactFont(to: "Stories: \(viewModel.stories.count)", for: "Stories:")
        seriesLabel.attributedText = applyImpactFont(to: "Series: \(viewModel.series.count)", for: "Series:")
        eventsLabel.attributedText = applyImpactFont(to: "Events: \(viewModel.events.count)", for: "Events:")
        characterImageView.sd_setImage(with: viewModel.imageUrl)
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private func applyImpactFont(to text: String, for word: String) -> NSAttributedString {
        let baseFont = UIFont.systemFont(ofSize: 13)
        let scaledFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: baseFont)
        
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: scaledFont,
                .foregroundColor: UIColor.textColor
            ]
        )
        
        let impactFont = UIFont(name: "Impact", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)
        let scaledImpactFont = UIFontMetrics(forTextStyle: .footnote).scaledFont(for: impactFont)
        let wordRange = (text as NSString).range(of: word)
        attributedString.setAttributes(
            [
                .font: scaledImpactFont,
                .foregroundColor: UIColor.systemYellow
            ],
            range: wordRange
        )
        return attributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = traitCollection.preferredContentSizeCategory
        let isBig = size >= .extraExtraExtraLarge
        finalStackView.axis = isBig ? .vertical : .horizontal
    }
}
