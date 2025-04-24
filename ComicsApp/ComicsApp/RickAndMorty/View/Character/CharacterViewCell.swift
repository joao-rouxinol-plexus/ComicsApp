//
//  CharacterViewCell.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 14/3/25.
//

import UIKit
import SDWebImage

class CharacterViewCell: UITableViewCell {

    
    public static var identifier: String{
        get{
            return "CharacterViewCell"
        }
    }
    
    public static func register() -> UINib{
        UINib(nibName: "CharacterViewCell", bundle: nil)
    }
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backView.addBorder(color: .black, width: 2)
        backView.round()
        characterImageView.round()
        statusView.layer.cornerRadius = statusView.frame.size.width / 2
        statusView.clipsToBounds = true
        //        self.backgroundColor = UIColor.init(red: 56/255, green: 173/255, blue: 169/255, alpha: 0.7)
    }

    func setUpCell(viewModel: CharacterTableCellViewModel){
        
        self.nameLabel.text = viewModel.name
        self.characterImageView.sd_setImage(with: viewModel.imageURL)
        self.idLabel.text = viewModel.status.rawValue.capitalized
        self.statusView.backgroundColor = viewModel.stautsColor(status: viewModel.status)
        self.locationLabel.text = "Localização:  \(viewModel.location.capitalized)"
    }
 
    
}

