//
//  MainCharacterCell.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 10/03/2025.
//

import UIKit
import SDWebImage
class MarvelMainCharacterCell: UITableViewCell {
    
    // MARK: - Identifier & Registration
    public static var identifier: String {
        get {
            return "MarvelMainCharacterCell"
        }
    }
    public static func register() -> UINib {
        UINib(nibName: "MarvelMainCharacterCell", bundle: nil)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.addBorder(color: .systemYellow , width: 2)
        backView.round()
        backView.backgroundColor = .boxBackgroundColor
        
        characterImageView.addBorder(color: .systemYellow, width: 2)
        characterImageView.round(10)
        
    }
    // MARK: - Helper Methods
    func applyImpactFont(to text: String, for word: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 13),.foregroundColor: UIColor.textColor])

            let wordRange = (text as NSString).range(of: word)

            attributedString.setAttributes([.font: UIFont(name: "Impact", size: 13) ?? UIFont.boldSystemFont(ofSize: 13),.foregroundColor: UIColor.systemYellow], range: wordRange)
            
            return attributedString
    }
    // MARK: - Cell Configuration
    func setUpCell(viewModel: MarvelCharacterViewModel) {
        self.nameLabel.text = viewModel.name
        nameLabel.textColor = .systemYellow
        self.descriptionLabel.text = viewModel.description
        descriptionLabel.textColor =  .textColor
        
        let comicsText = "Comics: \(viewModel.comics.count)"
        let storiesText = "Stories: \(viewModel.stories.count)"
        let seriesText = "Series: \(viewModel.series.count)"
        let eventsText = "Events: \(viewModel.events.count)"
        
        comicsLabel.attributedText = applyImpactFont(to: comicsText, for: "Comics:")
        storiesLabel.attributedText = applyImpactFont(to: storiesText, for: "Stories:")
        seriesLabel.attributedText = applyImpactFont(to: seriesText, for: "Series:")
        eventsLabel.attributedText = applyImpactFont(to: eventsText, for: "Events:")
        
        comicsLabel.textColor = .textColor
        storiesLabel.textColor = .textColor
        seriesLabel.textColor = .textColor
        eventsLabel.textColor = .textColor
        
        self.characterImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
