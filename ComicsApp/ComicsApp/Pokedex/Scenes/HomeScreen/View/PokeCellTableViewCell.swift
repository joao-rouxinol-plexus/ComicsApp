//
//  PokeCellTableViewCell.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.
//

import UIKit

class PokeCellTableViewCell: UITableViewCell {
    
    public static let identifier = "PokeCellTableViewCell"
    
    private var infoView : InfoView = InfoView()
    
    private var pokemonSprite : UIImageView = {
        let uiimageview = UIImageView()
        uiimageview.translatesAutoresizingMaskIntoConstraints = false
        return uiimageview
    }()
    
    private var spriteUIView : UIView = {
        let uiview = UIView()
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    }()
    
    private var shinyImageView : UIImageView = {
        let uiimageview = UIImageView()
        uiimageview.translatesAutoresizingMaskIntoConstraints = false
        uiimageview.image = UIImage(named: "shiny")!
        uiimageview.layer.opacity = 0.8
        uiimageview.isHidden = true
        return uiimageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(viewModel: PokemonListViewModel) {
        accessibilityLabel = "Number \(viewModel.id), \(viewModel.listInfo), Type \(viewModel.type1), \(viewModel.type2)"
        
        infoView.configure(id: "\(viewModel.formattedID)", name: viewModel.listInfo, type1: viewModel.type1, type2: viewModel.type2)
        self.pokemonSprite.sd_setImage(with: viewModel.sprite) {_,_,_,_ in
            let image: UIImage = self.pokemonSprite.image ?? UIImage()
            self.contentView.backgroundColor = image.dominantColor(0.85)
            self.shinyImageView.isHidden = !viewModel.shiny
        }
    }
    
    func setupHierarchy(){
        contentView.addSubview(infoView)
        contentView.addSubview(spriteUIView)
        spriteUIView.addSubview(pokemonSprite)
        contentView.addSubview(shinyImageView)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            infoView.trailingAnchor.constraint(equalTo: spriteUIView.leadingAnchor, constant: -5),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            spriteUIView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            spriteUIView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            spriteUIView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            spriteUIView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            pokemonSprite.centerXAnchor.constraint(equalTo: spriteUIView.centerXAnchor),
            pokemonSprite.centerYAnchor.constraint(equalTo: spriteUIView.centerYAnchor),
            pokemonSprite.widthAnchor.constraint(equalTo: pokemonSprite.heightAnchor),
            pokemonSprite.widthAnchor.constraint(lessThanOrEqualTo: spriteUIView.widthAnchor),
            pokemonSprite.heightAnchor.constraint(lessThanOrEqualTo: spriteUIView.heightAnchor),
            
            shinyImageView.heightAnchor.constraint(equalTo: shinyImageView.widthAnchor),
            shinyImageView.widthAnchor.constraint(equalTo: pokemonSprite.widthAnchor, multiplier: 0.6),
            shinyImageView.trailingAnchor.constraint(equalTo: pokemonSprite.trailingAnchor),
            shinyImageView.topAnchor.constraint(equalTo: pokemonSprite.topAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.squircle()
    }
}
