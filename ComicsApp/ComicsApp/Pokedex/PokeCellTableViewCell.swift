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
    
    public static func register() -> UINib{
        UINib(nibName: "PokeCellTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(viewModel: SpeciesViewModel) {
        self.pokemonNumber.text = "\(viewModel.id)"
        self.pokemonLabel.text = viewModel.listInfo
        self.pokemonSprite.sd_setImage(with: viewModel.imageURL)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.backgroundColor = .lightGray
    }
    
}
