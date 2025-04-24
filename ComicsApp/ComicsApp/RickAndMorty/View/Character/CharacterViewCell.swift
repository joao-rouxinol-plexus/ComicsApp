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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.addBorder(color: .gray, width: 2)
        backView.round()
        characterImageView.round()
        statusView.layer.cornerRadius = statusView.frame.size.width / 2
        setUpAcessibility()
    }

    func setUpCell(viewModel: CharacterTableCellViewModel){
        
        self.nameLabel.text = viewModel.name
        self.characterImageView.sd_setImage(with: viewModel.imageURL)
        self.statusLabel.text = viewModel.status.rawValue.capitalized
        self.statusView.backgroundColor = viewModel.stautsColor(status: viewModel.status)
        self.locationLabel.text = "Current location: \(viewModel.location.capitalized)"
    }
 
    private func setUpAcessibility() {
            
        self.isAccessibilityElement = false
        
        nameLabel.isAccessibilityElement = true
        nameLabel.accessibilityHint = "Name of character"
        
        characterImageView.isAccessibilityElement = true
        characterImageView.accessibilityHint = "Image of character"
        
        statusLabel.isAccessibilityElement = true
        statusLabel.accessibilityHint = "Current status of the character"
        
        locationLabel.isAccessibilityElement = true
        locationLabel.accessibilityHint = "Current location of the character"
        

        let actionHint = UIAccessibilityElement(accessibilityContainer: self)
        actionHint.accessibilityLabel = "Double Tap to open details"
        actionHint.accessibilityTraits = .button
        
        self.accessibilityElements = [nameLabel!, characterImageView!, statusLabel!, locationLabel!, actionHint]
    }
}

