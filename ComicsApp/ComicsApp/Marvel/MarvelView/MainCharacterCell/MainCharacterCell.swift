//
//  MainCharacterCell.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 10/03/2025.
//

import UIKit
import SDWebImage

class MainCharacterCell: UITableViewCell {
    
    public static var identifier: String {
        get{
            return "MainCharacterCell"
        }
    }
    
    public static func register() -> UINib {
        UINib(nibName: "MainCharacterCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var storiesLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    
    @IBOutlet weak var eventsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addBorder(color: .systemYellow , width: 2)
        backView.round()
        characterImageView.addBorder(color: .systemYellow, width: 2)
        characterImageView.round(10)
        backView.backgroundColor = .darkGray
    }
    
    func setUpCell(viewModel: CharacterTableCellViewModel){
        self.nameLabel.text = viewModel.name
        nameLabel.textColor = .systemYellow
        self.descriptionLabel.text = viewModel.description
        descriptionLabel.textColor = .white
        let comicsText = "Comics: \(viewModel.comics.count)"
        let storiesText = "Stories: \(viewModel.stories.count)"
        let seriesText = "Series: \(viewModel.series.count)"
        let eventsText = "Events: \(viewModel.events.count)"
        
        let comicsRange = (comicsText as NSString).range(of: "Comics:")
        let boldComicsText = comicsText.boldPart(range: comicsRange)
            
        let storiesRange = (storiesText as NSString).range(of: "Stories:")
        let boldStoriesText = storiesText.boldPart(range: storiesRange)
        
        let seriesRange = (seriesText as NSString).range(of: "Series:")
        let boldSeriesText = seriesText.boldPart(range: seriesRange)
            
        let eventsRange = (eventsText as NSString).range(of: "Events:")
        let boldEventsText = eventsText.boldPart(range: eventsRange)
            
        self.comicsLabel.attributedText = boldComicsText
        self.storiesLabel.attributedText = boldStoriesText
        self.seriesLabel.attributedText = boldSeriesText
        self.eventsLabel.attributedText = boldEventsText
        
        comicsLabel.textColor = .white
        storiesLabel.textColor = .white
        seriesLabel.textColor = .white
        eventsLabel.textColor = .white
        
        self.characterImageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    
}
