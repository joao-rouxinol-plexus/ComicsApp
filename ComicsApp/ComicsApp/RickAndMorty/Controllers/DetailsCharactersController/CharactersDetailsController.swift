//
//  DetailsCharactersController.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit
import SDWebImage

class CharactersDetailsController: UIViewController {
    
    var viewModel : CharacterDetailsViewModel
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Character Details"
        view.backgroundColor = .systemBackground
        
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.init(red: 56/255, green: 173/255, blue: 169/255, alpha: 0.6)
        
        
        view.addSubview(view1)
        
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            view1.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            view1.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = viewModel.characterName
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        view1.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view1.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view1.topAnchor, constant: 20)
        ])
        
        let imageView = UIImageView()
        imageView.sd_setImage(with: viewModel.characterImgUrl)
        imageView.contentMode = .center
        view1.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.centerXAnchor),
            imageView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.topAnchor,constant: 100)
        ])
        
        let statusLabel = UILabel()
        if viewModel.characterStatus.rawValue == "Alive" {
            statusLabel.textColor = .green
        } else {
            statusLabel.textColor = .red
        }
        statusLabel.text = "\(viewModel.characterStatus)".capitalized
        view1.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.bottomAnchor,constant: -40),
            statusLabel.safeAreaLayoutGuide.centerXAnchor.constraint(equalTo: view1.safeAreaLayoutGuide.centerXAnchor)
        ])
    
        
    }
    
}
