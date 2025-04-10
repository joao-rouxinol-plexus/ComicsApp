//
//  ViewControllerView.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 8/4/25.
//

import UIKit

class ViewControllerView : UIView{
    
    private var viewModel: ViewControllerViewModel
    
    private let pokeImageView = UIImageView()
    private let marvelImageView = UIImageView()
    private let rmImageView = UIImageView()
    private var tapPokeImageView: UITapGestureRecognizer!
    private var tapMarvelImageView: UITapGestureRecognizer!
    private var tapRMImageView: UITapGestureRecognizer!
    
    
    enum UniverseTapped {
        case pokemon
        case marvel
        case rm
    }
    
    public var getUniverseTapped : ((UniverseTapped) -> Void)?
    
    init(viewModel: ViewControllerViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setUpLayout()
        setUpGesturesRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayout(){
        
        pokeImageView.translatesAutoresizingMaskIntoConstraints = false
        pokeImageView.round()
        pokeImageView.addBorder(color: .systemGray, width: 5)
        pokeImageView.contentMode = .scaleAspectFill
        pokeImageView.image = viewModel.pokemonImage
        pokeImageView.isUserInteractionEnabled = true
        
        
        marvelImageView.translatesAutoresizingMaskIntoConstraints = false
        marvelImageView.round()
        marvelImageView.addBorder(color: .systemGray, width: 5)
        marvelImageView.contentMode = .scaleAspectFill
        marvelImageView.image = viewModel.marvelImage
        marvelImageView.isUserInteractionEnabled = true
        
        
        rmImageView.translatesAutoresizingMaskIntoConstraints = false
        rmImageView.round()
        rmImageView.addBorder(color: .systemGray, width: 5)
        rmImageView.contentMode = .scaleAspectFill
        rmImageView.image = viewModel.rmImage
        rmImageView.isUserInteractionEnabled = true
        
        
        let stackView = UIStackView(arrangedSubviews: [pokeImageView, marvelImageView, rmImageView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 5),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 5),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -5),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -5)
        ])
        
    }
    
    private func setUpGesturesRecognizer(){
        
        tapPokeImageView = UITapGestureRecognizer(target: self, action: #selector(dectetedTap))
        tapMarvelImageView = UITapGestureRecognizer(target: self, action: #selector(dectetedTap))
        tapRMImageView = UITapGestureRecognizer(target: self, action: #selector(dectetedTap))
        
        pokeImageView.addGestureRecognizer(tapPokeImageView)
        marvelImageView.addGestureRecognizer(tapMarvelImageView)
        rmImageView.addGestureRecognizer(tapRMImageView)
        
    }
    
    @objc private func dectetedTap(_ sender: UITapGestureRecognizer) {
        
        guard let tappedView = sender.view else { return }
        
        switch tappedView{
            
        case pokeImageView:
            
            getUniverseTapped?(.pokemon)
            
        case marvelImageView:
            
            getUniverseTapped?(.marvel)
            
        case rmImageView:
            
            getUniverseTapped?(.rm)
            
        default:
            break
        }
    }
}



