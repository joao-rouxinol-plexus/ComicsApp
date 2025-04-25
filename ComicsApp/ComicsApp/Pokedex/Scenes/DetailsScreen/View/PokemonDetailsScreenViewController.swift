//
//  PokemonDetailsScreenViewController.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 21/03/2025.
//

import Foundation
import UIKit

class PokemonDetailsScreenViewController: UIViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            setOrientation()
        }
    }
    
    var viewModel : PokemonViewModel
    
    private var backgroundColorVariable : UIColor = .systemGray.lighter(by: 0.3)!
    private var userInterfaceColor : UIColor = .systemGray
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "pokemon")
        return imageView
    }()
    
    private let myView : UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private let heightAndInfoCell : PokemonHeightAndInfoCell = {
        let speciesinfo = PokemonHeightAndInfoCell()
        speciesinfo.translatesAutoresizingMaskIntoConstraints = false
        return speciesinfo
    }()
    
    private static func createTitle(_ title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold).makeScaleable()
        label.adjustsFontForContentSizeCategory = true
        return label
    }
    
    private let abilitiesTitle = createTitle("Abilities")
    private let statsTitle = createTitle("Base Stats")
    
    private let abilitiesStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.squircle()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let statsContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let statsStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.squircle()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let topView : UIView = {
        let topView = UIView()
        topView.squircle()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    
    private var infoView : PokemonInfoView = {
        
        let infoView = PokemonInfoView(isAccessible: true)
        infoView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        infoView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return infoView
    }()
    
    init(pokemonViewModel: PokemonViewModel){
        self.viewModel = pokemonViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareDetails()
    }
    
    func setOrientation(){
        
        let greaterThanMedium = traitCollection.preferredContentSizeCategory >= .accessibilityMedium
        
        infoView.setOrientation(useVerticalLayout: greaterThanMedium)
        
        heightAndInfoCell.setOrientation()
        
        abilitiesStackView.subviews.compactMap { $0 as? PokemonAbilityCell }
            .forEach { $0.setOrientation(useVerticalLayout: greaterThanMedium)}
        
        statsStackView.subviews.compactMap { $0 as? PokemonStatCell }
            .forEach { $0.setOrientation(useVerticalLayout: greaterThanMedium)}
    }
    
    func prepareDetails(){
        title = "Details"
        infoView.configure(id: String(format: "#%03d", viewModel.id), name: viewModel.name, type1: viewModel.type1, type2: viewModel.type2)
        heightAndInfoCell.configure(heigth: String(viewModel.height), weight: String(viewModel.weight))
        setupHierarchy()
        setupImage()
        mapAbilitiesStackView()
        mapStatsStackView()
        addConstraints()
        setOrientation()
    }
    
    func setupHierarchy(){
        view.addSubview(myView)
        myView.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(topView)
        topView.addSubview(infoView)
        contentView.addSubview(heightAndInfoCell)
        contentView.addSubview(abilitiesTitle)
        contentView.addSubview(abilitiesStackView)
        contentView.addSubview(statsTitle)
        contentView.addSubview(statsContentStackView)
        
        statsContentStackView.addArrangedSubview(statsStackView)
        statsContentStackView.addArrangedSubview(UIView())
    }
    
    func setupColor(){
        self.myView.backgroundColor = self.userInterfaceColor
        self.topView.addSubview(self.imageView)
        self.topView.backgroundColor = self.backgroundColorVariable
        self.scrollView.backgroundColor = self.userInterfaceColor
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = self.backgroundColorVariable.darker(by: 0.2)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: self.backgroundColorVariable.darker(by: 0.2)!]
        }
        
        abilitiesStackView.subviews.forEach {
            if let abilityCell = $0 as? PokemonAbilityCell {
                abilityCell.backgroundColor = userInterfaceColor
                abilityCell.hiddenAbilityView.backgroundColor = backgroundColorVariable
            }
        }
        
        statsStackView.subviews.forEach {
            if let statCell = $0 as? PokemonStatCell {
                statCell.statBar.backgroundColor = userInterfaceColor
                statCell.textBackgroundView.backgroundColor = backgroundColorVariable
            }
        }
    }
    
    func setupImage(){
        self.setupColor()
        imageView.sd_setImage(with: URL(string: viewModel.shinyCorrectedSprite)){_,_,_,_ in
            
            let image: UIImage = self.imageView.image ?? UIImage(named: "pokemon")!
            let color : UIColor = image.dominantColor() ?? .systemGray.darker(by: 0.4)!
            
            self.backgroundColorVariable = color
            self.userInterfaceColor =  color.lighter(by: 0.2)!
            self.setupColor()
            
            NSLayoutConstraint.activate([
                self.imageView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -5),
                self.imageView.leadingAnchor.constraint(equalTo: self.infoView.trailingAnchor, constant: 5),
                self.imageView.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
                self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor),
                self.imageView.heightAnchor.constraint(lessThanOrEqualTo: self.topView.heightAnchor),
                self.imageView.heightAnchor.constraint(lessThanOrEqualTo: self.myView.heightAnchor, multiplier: 0.2)
            ])
        }
        
    }
    
    func mapStatsStackView(){
        
        let stats = viewModel.statsVM
        
        statsStackView.axis = .vertical
        statsStackView.spacing = 10
        statsStackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        statsStackView.isLayoutMarginsRelativeArrangement = true
        
        for stat in stats{
            
            let statCell = PokemonStatCell(name: stat.name, value: stat.value, largestName: viewModel.largestStatName)
            
            statCell.statBar.backgroundColor = userInterfaceColor
            statCell.textBackgroundView.backgroundColor = backgroundColorVariable
            
            statsStackView.addArrangedSubview(statCell)
            
            let percentageOfLargestStat : CGFloat = max((CGFloat(stat.value) / CGFloat(viewModel.largestStat)), 0.2)
            
            NSLayoutConstraint.activate([
                statCell.statBar.widthAnchor.constraint(equalTo: statCell.statBarLimit.widthAnchor, multiplier: percentageOfLargestStat, constant: 10)
            ])
        }
    }
    
    func mapAbilitiesStackView(){
        
        let abilities = viewModel.abilities
        abilitiesStackView.axis = .vertical
        abilitiesStackView.spacing = 10
        abilitiesStackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        abilitiesStackView.isLayoutMarginsRelativeArrangement = true
        
        for ability in abilities{
            
            let abilityName = ability.ability.name.split(separator: "-").joined(separator: " ").capitalized
            let abilityCell = PokemonAbilityCell(name: abilityName, hidden: ability.is_hidden)
            
            abilityCell.backgroundColor = userInterfaceColor
            abilityCell.hiddenAbilityView.backgroundColor = backgroundColorVariable
            
            abilitiesStackView.addArrangedSubview(abilityCell)
        }
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            // myView
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myView.topAnchor.constraint(equalTo: view.topAnchor),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            // infoView
            infoView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10),
            infoView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            infoView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 15),
            infoView.widthAnchor.constraint(greaterThanOrEqualTo: topView.widthAnchor, multiplier: 0.65),
            topView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 15),
            
            // SCROLL VIEW
            scrollView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            
            // CONTENT VIEW
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // TopView
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
 
            //heightAndWeightCell
            heightAndInfoCell.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            heightAndInfoCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            heightAndInfoCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            // ABILITIES TITLE
            abilitiesTitle.topAnchor.constraint(equalTo: heightAndInfoCell.bottomAnchor, constant: 10),
            abilitiesTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // ABILITIES STACK VIEW
            abilitiesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            abilitiesStackView.topAnchor.constraint(equalTo: abilitiesTitle.bottomAnchor, constant: 15),
            abilitiesStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // STATS TITLE
            statsTitle.topAnchor.constraint(equalTo: abilitiesStackView.bottomAnchor, constant: 20),
            statsTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            // STATS STACK VIEW
            statsContentStackView.topAnchor.constraint(equalTo: statsTitle.bottomAnchor, constant: 15),
            statsContentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            statsContentStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statsContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
    }
}
