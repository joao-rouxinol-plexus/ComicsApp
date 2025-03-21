//
//  DetailViewController.swift
//  ComicsApp
//
//  Created by Mariana Alexandre Dos Santos on 21/03/2025.
//

import Foundation
import UIKit

class DetailViewController : UIViewController{
    var character : CharacterTableCellViewModel?
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func createBoxView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemYellow.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private var characterBox = UIView()
    private var comicsBox = UIView()
    private var storiesBox = UIView()
    private var seriesBox = UIView()
    private var eventsBox = UIView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemYellow.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let comicsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let storiesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let storiesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let seriesTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seriesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventsTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = .systemYellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eventsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupUI()
        configure()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        

        characterBox = createBoxView()
        comicsBox = createBoxView()
        storiesBox = createBoxView()
        seriesBox = createBoxView()
        eventsBox = createBoxView()

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterBox)
        contentView.addSubview(comicsBox)
        contentView.addSubview(storiesBox)
        contentView.addSubview(seriesBox)
        contentView.addSubview(eventsBox)

        characterBox.addSubview(descriptionTitle)
        characterBox.addSubview(descriptionLabel)

        comicsBox.addSubview(comicsTitle)
        comicsBox.addSubview(comicsLabel)

        storiesBox.addSubview(storiesTitle)
        storiesBox.addSubview(storiesLabel)

        seriesBox.addSubview(seriesTitle)
        seriesBox.addSubview(seriesLabel)

        eventsBox.addSubview(eventsTitle)
        eventsBox.addSubview(eventsLabel)

        NSLayoutConstraint.activate([
//            parte de cima sem box imagem + nome
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
//            box com descriçao (title + text)
            characterBox.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            characterBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            characterBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionTitle.topAnchor.constraint(equalTo: characterBox.topAnchor, constant: 10),
            descriptionTitle.leadingAnchor.constraint(equalTo: characterBox.leadingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: characterBox.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: characterBox.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: characterBox.bottomAnchor, constant: -10),
            
//            box com comics (title + text)
            comicsBox.topAnchor.constraint(equalTo: characterBox.bottomAnchor, constant: 20),
            comicsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            comicsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            comicsTitle.topAnchor.constraint(equalTo: comicsBox.topAnchor, constant: 10),
            comicsTitle.leadingAnchor.constraint(equalTo: comicsBox.leadingAnchor, constant: 10),
            comicsLabel.topAnchor.constraint(equalTo: comicsTitle.bottomAnchor, constant: 5),
            comicsLabel.leadingAnchor.constraint(equalTo: comicsBox.leadingAnchor, constant: 10),
            comicsLabel.trailingAnchor.constraint(equalTo: comicsBox.trailingAnchor, constant: -10),
            comicsLabel.bottomAnchor.constraint(equalTo: comicsBox.bottomAnchor, constant: -10),
            
//            box com stories (title + text)
            storiesBox.topAnchor.constraint(equalTo: comicsBox.bottomAnchor, constant: 20),
            storiesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            storiesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            storiesTitle.topAnchor.constraint(equalTo: storiesBox.topAnchor, constant: 10),
            storiesTitle.leadingAnchor.constraint(equalTo: storiesBox.leadingAnchor, constant: 10),
            storiesLabel.topAnchor.constraint(equalTo: storiesTitle.bottomAnchor, constant: 5),
            storiesLabel.leadingAnchor.constraint(equalTo: storiesBox.leadingAnchor, constant: 10),
            storiesLabel.trailingAnchor.constraint(equalTo: storiesBox.trailingAnchor, constant: -10),
            storiesLabel.bottomAnchor.constraint(equalTo: storiesBox.bottomAnchor, constant: -10),
            
//            box com series (title + text)
            seriesBox.topAnchor.constraint(equalTo: storiesBox.bottomAnchor, constant: 20),
            seriesBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            seriesBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            seriesTitle.topAnchor.constraint(equalTo: seriesBox.topAnchor, constant: 10),
            seriesTitle.leadingAnchor.constraint(equalTo: seriesBox.leadingAnchor, constant: 10),
            seriesLabel.topAnchor.constraint(equalTo: seriesTitle.bottomAnchor, constant: 5),
            seriesLabel.leadingAnchor.constraint(equalTo: seriesBox.leadingAnchor, constant: 10),
            seriesLabel.trailingAnchor.constraint(equalTo: seriesBox.trailingAnchor, constant: -10),
            seriesLabel.bottomAnchor.constraint(equalTo: seriesBox.bottomAnchor, constant: -10),
            
//            box com event (title + text)
            eventsBox.topAnchor.constraint(equalTo: seriesBox.bottomAnchor, constant: 20),
            eventsBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            eventsBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            eventsBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            eventsTitle.topAnchor.constraint(equalTo: eventsBox.topAnchor, constant: 10),
            eventsTitle.leadingAnchor.constraint(equalTo: eventsBox.leadingAnchor, constant: 10),
            eventsLabel.topAnchor.constraint(equalTo: eventsTitle.bottomAnchor, constant: 5),
            eventsLabel.leadingAnchor.constraint(equalTo: eventsBox.leadingAnchor, constant: 10),
            eventsLabel.trailingAnchor.constraint(equalTo: eventsBox.trailingAnchor, constant: -10),
            eventsLabel.bottomAnchor.constraint(equalTo: eventsBox.bottomAnchor, constant: -10)
        ])
    }
    
    private func configure() {
        guard let character = character else { return }
        nameLabel.text = character.name
        descriptionTitle.text = "Description"
        descriptionLabel.text = character.description
        comicsTitle.text = "Comics"
        comicsLabel.text = "• \( character.comics.joined(separator: "\n •"))"
        storiesTitle.text = "Stories"
        storiesLabel.text = "• \( character.stories.joined(separator: "\n •"))"
        seriesTitle.text = "Series"
        seriesLabel.text = "• \( character.series.joined(separator: "\n •"))"
        eventsTitle.text = "Events"
        eventsLabel.text = "• \( character.events.joined(separator: "\n •"))"

        if let imageUrl = character.imageUrl {
            URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
