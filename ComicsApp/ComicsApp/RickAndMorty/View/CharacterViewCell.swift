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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backView.addBorder(color: .black, width: 2)
        backView.round()
        
        characterImageView.round(10)
        
        self.backgroundColor = UIColor.init(red: 56/255, green: 173/255, blue: 169/255, alpha: 0.7)
    }

    func setUpCell(viewModel: CharacterTableCellViewModel){
        
        self.nameLabel.text = viewModel.name
        self.characterImageView.sd_setImage(with: viewModel.imageURL)
        self.idLabel.text = "ID: \(viewModel.id)"
    }
 
    
}
