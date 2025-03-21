//
//  PokeCellTableViewCell.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.
//

import UIKit

class PokeCellTableViewCell: UITableViewCell {
    public static let identifier = "PokeCellTableViewCell"
    
    @IBOutlet weak var pokemonSprite: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var shiny: UIImageView!
    @IBOutlet weak var Type1Label: UILabel!
    @IBOutlet weak var Type2Label: UILabel!
    
    public static func register() -> UINib{
        UINib(nibName: "PokeCellTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(viewModel: PokemonListViewModel, indexPath: IndexPath) {
        self.pokemonNumber.text = "\(viewModel.formattedID)"
        self.pokemonLabel.text = viewModel.listInfo
        
        self.pokemonSprite.sd_setImage(with: viewModel.sprite) {_,_,_,_ in
            let daimage: UIImage = self.pokemonSprite.image ?? UIImage()
            self.contentView.backgroundColor = daimage.dominantColor()
        }
        
        self.shiny.isHidden = !viewModel.shiny
        self.Type1Label.text = viewModel.type1
        self.Type2Label.text = viewModel.type2
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.alpha = 1
        //        contentView.backgroundColor = .lightGray
    }
}


