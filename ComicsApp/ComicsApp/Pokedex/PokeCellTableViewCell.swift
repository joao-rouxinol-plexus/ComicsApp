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
    @IBOutlet weak var TypesView: UIView!
    
    
    private var poketypeview : pokeTypeView = pokeTypeView()
    
    public static func register() -> UINib{
        UINib(nibName: "PokeCellTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awoken")
        TypesView.addSubview(poketypeview)
        NSLayoutConstraint.activate([
            poketypeview.widthAnchor.constraint(equalTo: TypesView.widthAnchor),
            poketypeview.heightAnchor.constraint(equalTo: TypesView.heightAnchor)
        ])
    }

    func setupCell(viewModel: PokemonListViewModel) {
        self.pokemonNumber.text = "\(viewModel.formattedID)"
        self.pokemonLabel.text = viewModel.listInfo
        
        self.pokemonSprite.sd_setImage(with: viewModel.sprite) {_,_,_,_ in
            let image: UIImage = self.pokemonSprite.image ?? UIImage()
            self.contentView.backgroundColor = image.dominantColor(0.85)
        }
        
        self.shiny.isHidden = !viewModel.shiny
        poketypeview.configure(type1: viewModel.type1, type2: viewModel.type2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.squircle()
    }
}

class pokeTypeView: UIView {
    
    let type1View: UILabel = {
        let view = UILabel()
        view.squircle()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.textColor = .label
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let type2View: UILabel = {
        let view = UILabel()
        view.squircle()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.textColor = .label
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(type1: String, type2: String){
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure(type1: type1, type2: type2)
    }
    
    func configure(type1: String, type2: String){
        subviews.forEach({$0.removeFromSuperview()})
        type1View.text = type1
        type2View.text = type2
        addSubview(type1View)
        
        NSLayoutConstraint.activate([
            type1View.topAnchor.constraint(equalTo: topAnchor),
            type1View.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            type1View.heightAnchor.constraint(equalToConstant: 30)])
        
        if (type2 != "") {
            addSubview(type2View)
            NSLayoutConstraint.activate([
                type2View.topAnchor.constraint(equalTo: topAnchor),
                type2View.leadingAnchor.constraint(equalTo: type1View.trailingAnchor, constant: 10),
                type2View.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                type2View.widthAnchor.constraint(equalTo: type1View.widthAnchor),
                type2View.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                type1View.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

