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
        get{
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
        characterImageView.addBorder(color: .systemYellow, width: 2)
        characterImageView.round(10)
        backView.backgroundColor = .boxBackgroundColor
    }
    
    // MARK: - Helper Methods
    func applyImpactFont(to text: String, for keyword: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        if let range = text.range(of: keyword) {
            let nsRange = NSRange(range, in: text)
            attributedString.addAttribute(.font, value: UIFont(name: "Impact", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .bold), range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: nsRange)
        }
        return attributedString
    }
    
    // MARK: - Cell Configuration
    func setUpCell(viewModel: MarvelCharacterViewModel){
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
