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
            infoView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
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

class InfoView : UIView {
    
    private var nameandnumberview : NameAndNumberView = NameAndNumberView()
    private var poketypeview : pokeTypeView = pokeTypeView()
    
    
    init(){
        super.init(frame: .zero)
        addSubview(nameandnumberview)
        addSubview(poketypeview)
        translatesAutoresizingMaskIntoConstraints = false
        //        backgroundColor = .red
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure (id: String, name: String, type1: String, type2: String){
        nameandnumberview.configure(id: id, name: name)
        poketypeview.configure(type1: type1, type2: type2)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            nameandnumberview.topAnchor.constraint(equalTo: topAnchor),
            nameandnumberview.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameandnumberview.widthAnchor.constraint(equalTo: widthAnchor),
            nameandnumberview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6666666),
            
            
            poketypeview.topAnchor.constraint(equalTo: nameandnumberview.bottomAnchor),
            poketypeview.trailingAnchor.constraint(equalTo: trailingAnchor),
            poketypeview.widthAnchor.constraint(equalTo: widthAnchor),
            //            poketypeview.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3333333),
            poketypeview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}


class NameAndNumberView: UIView {
    
    let pokemonNumber: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        //        view.backgroundColor = .black
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    let pokemonName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20, weight: .regular)
        //        view.backgroundColor = .systemPink
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        //        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(pokemonName)
        addSubview(pokemonNumber)
        configureConstraints()
    }
    
    func configure(id: String, name: String){
        pokemonNumber.text="\(id)"
        pokemonName.text=name
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            pokemonNumber.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonNumber.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            pokemonName.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            type1View.leadingAnchor.constraint(equalTo: leadingAnchor),
            type1View.heightAnchor.constraint(equalToConstant: 30)])
        
        if (type2 != "") {
            addSubview(type2View)
            NSLayoutConstraint.activate([
                type2View.topAnchor.constraint(equalTo: topAnchor),
                type2View.leadingAnchor.constraint(equalTo: type1View.trailingAnchor, constant: 10),
                type2View.trailingAnchor.constraint(equalTo: trailingAnchor),
                type2View.widthAnchor.constraint(equalTo: type1View.widthAnchor),
                type2View.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                type1View.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

