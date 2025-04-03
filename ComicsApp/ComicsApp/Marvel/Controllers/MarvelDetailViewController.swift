//
//  DetailViewController.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 21/03/2025.
//

import Foundation
import UIKit
import SDWebImage

class MarvelDetailViewController : UIViewController{
    
    // MARK: - Properties
    var character : MarvelCharacterViewModel?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemYellow.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Impact", size: 25)
        label.textAlignment = .center
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .backgroundColor
        
        setupUI()
        configure()
    }
    
    // MARK: - UI Setup Methods
    private func createBoxView(title: String, content: String) -> MarvelBoxView {
        let boxView = MarvelBoxView(title: title, content: content)
        boxView.translatesAutoresizingMaskIntoConstraints = false
        return boxView
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        let characterBox = createBoxView(title: "Description", content: character?.description ?? "No description")
        let comicsBox = createBoxView(title: "Comics", content: "• \(character?.comics.joined(separator: "\n •") ?? "")")
        let storiesBox = createBoxView(title: "Stories", content: "• \(character?.stories.joined(separator: "\n •") ?? "")")
        let seriesBox = createBoxView(title: "Series", content: "• \(character?.series.joined(separator: "\n •") ?? "")")
        let eventsBox = createBoxView(title: "Events", content: "• \(character?.events.joined(separator: "\n •") ?? "")")
        
        characterBox.setup()
        comicsBox.setup()
        storiesBox.setup()
        seriesBox.setup()
        eventsBox.setup()
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(characterBox)
        contentView.addSubview(comicsBox)
        contentView.addSubview(storiesBox)
        contentView.addSubview(seriesBox)
        contentView.addSubview(eventsBox)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            characterBox.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            characterBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            comicsBox.topAnchor.constraint(equalTo: characterBox.bottomAnchor, constant: 20),
            comicsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comicsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            storiesBox.topAnchor.constraint(equalTo: comicsBox.bottomAnchor, constant: 20),
            storiesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storiesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            seriesBox.topAnchor.constraint(equalTo: storiesBox.bottomAnchor, constant: 20),
            seriesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            seriesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            eventsBox.topAnchor.constraint(equalTo: seriesBox.bottomAnchor, constant: 20),
            eventsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration Methods
    private func configure() {
        guard let character = character else { return }
        nameLabel.text = character.name
        
        if let imageUrl = character.imageUrl {
            imageView.sd_setImage(with: imageUrl)
        }
    }
}
