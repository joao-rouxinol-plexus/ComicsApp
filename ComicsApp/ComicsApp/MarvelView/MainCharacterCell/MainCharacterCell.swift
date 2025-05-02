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
    
//    IBoutlets:
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
        backView.addBorder(color: .label , width: 2)
        backView.round()
        characterImageView.addBorder(color: .label, width: 1)
        characterImageView.round(10)
        backView.backgroundColor = .yellow
    }
    func setUpCell(viewModel: CharacterTableCellViewModel){
        self.nameLabel.text = viewModel.name
        self.descriptionLabel.text = viewModel.description
        let comicsText = "Comics: \(viewModel.comics)"
        let storiesText = "Stories: \(viewModel.stories)"
        let seriesText = "Series: \(viewModel.series)"
        let eventsText = "Events: \(viewModel.events)"
        
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
        
//        let seriesWord = "Series: \(viewModel.series)"
//        self.seriesLabel.attributedText = seriesWord.bold
//        let eventsWord = "Events: \(viewModel.events)"
//        self.eventsLabel.attributedText = eventsWord.bold
        self.characterImageView.sd_setImage(with: viewModel.imageUrl)
    }
    
    
}
