//
//  PokemonDetailsScreenViewController.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 21/03/2025.
//


import Foundation
import UIKit

class PokemonDetailsScreenViewController: UIViewController {
    
    var viewModel : PokemonViewModel
    
    private var backgroundColorVariable : UIColor = .systemGray.lighter(by: 0.3)!
    private var userInterfaceColor : UIColor = .systemGray
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let myView : UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        return myView
    }()
    
    private let abilitiesTitle : UILabel = {
        let textField = UILabel()
        textField.text = "Abilities"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        return textField
    }()
    
    private let abilitiesStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.squircle()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let statsTitle : UILabel = {
        let textField = UILabel()
        textField.text = "Base Stats"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .darkText
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 18, weight: .bold)
        return textField
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
        scrollView.backgroundColor = .blue
        return scrollView
    }()
    
    private var infoView : InfoView = InfoView()
    
    init(pokemonViewModel: PokemonViewModel){
        self.viewModel = pokemonViewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PrepareDetails()
    }
    
    func PrepareDetails(){
        infoView.configure(id: String(format: "#%03d", viewModel.id), name: viewModel.name, type1: viewModel.type1, type2: viewModel.type2)
        setupHierarchy()
        setupImage()
        mapAbilitiesStackView()
        mapStatsStackView()
        self.addConstraints()
    }
    
    func setupHierarchy(){
        view.addSubview(myView)
        myView.addSubview(topView)
        topView.addSubview(infoView)
        myView.addSubview(scrollView)
        
        scrollView.addSubview(abilitiesTitle)
        scrollView.addSubview(abilitiesStackView)
        scrollView.addSubview(statsTitle)
        scrollView.addSubview(statsStackView)
    }
    
    func setupColor(){
        self.myView.backgroundColor = self.userInterfaceColor
        self.topView.addSubview(self.imageView)
        self.topView.backgroundColor = self.backgroundColorVariable
        self.scrollView.backgroundColor = self.userInterfaceColor
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = self.backgroundColorVariable.darker(by: 0.2)
        }
    }
    
    func setupImage(){
        imageView.sd_setImage(with: URL(string: viewModel.shinyCorrectedSprite)){_,_,_,_ in
            
            let image: UIImage = self.imageView.image ?? UIImage(named: "pokemon")!
            let color : UIColor = image.dominantColor() ?? .systemGray.darker(by: 0.4)!
            
            self.backgroundColorVariable = color
            self.userInterfaceColor =  color.lighter(by: 0.2)!
            self.setupColor()
            
            NSLayoutConstraint.activate([
                self.imageView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -15),
                self.imageView.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
                self.imageView.heightAnchor.constraint(equalTo: self.topView.heightAnchor, multiplier: 0.8),
                self.imageView.widthAnchor.constraint(equalTo: self.topView.heightAnchor, multiplier: 0.8)])
        }
    }
    
    func mapStatsStackView(){
        
        let stats = viewModel.statsVM
        
        var lastStat : StatCell? = nil
        
        for stat in stats{
            
            let statName = stat.name.split(separator: "-").joined(separator: " ").capitalized
            let statCell = StatCell(name: statName, value: stat.value)
            
            statCell.backgroundColor = userInterfaceColor
            statCell.textBackgroundView.backgroundColor = backgroundColorVariable
            
            statsStackView.addSubview(statCell)
            
            let constrainedPercentage : CGFloat = 0.35 + (0.92 - 0.35) * (CGFloat(stat.value) / CGFloat(viewModel.largestStat))
            
            NSLayoutConstraint.activate([
                statCell.textBackgroundView.widthAnchor.constraint(equalTo: statsStackView.widthAnchor, multiplier: 0.35),
                statCell.leadingAnchor.constraint(equalTo: statsStackView.leadingAnchor, constant: 15),
                statCell.topAnchor.constraint(equalTo: lastStat?.bottomAnchor ?? statsStackView.topAnchor, constant: lastStat == nil ? 15 : 10),
                statCell.widthAnchor.constraint(equalTo: statsStackView.widthAnchor, multiplier: constrainedPercentage)
            ])
            
            lastStat = statCell
        }
        
        let initialAndFinalSpacing : CGFloat = 15*2
        let listSpacing : CGFloat = 10
        let cellHeight: CGFloat = lastStat?.cellHeight ?? 0
        
        NSLayoutConstraint.activate([
            statsStackView.heightAnchor.constraint(equalToConstant: CGFloat(initialAndFinalSpacing + cellHeight * CGFloat(stats.count) + listSpacing * CGFloat(stats.count - 1)))
        ])
    }
    
    func mapAbilitiesStackView(){
        
        let abilities = viewModel.abilities
        var lastAbility : AbilityCell? = nil
        
        for ability in abilities{
            
            let abilityName = ability.ability.name.split(separator: "-").joined(separator: " ").capitalized
            let abilityCell = AbilityCell(name: abilityName, hidden: ability.is_hidden)
            
            abilityCell.backgroundColor = userInterfaceColor
            
            abilityCell.hiddenAbilityView.backgroundColor = backgroundColorVariable
            
            abilitiesStackView.addSubview(abilityCell)
            
            NSLayoutConstraint.activate([
                abilityCell.leadingAnchor.constraint(equalTo: abilitiesStackView.leadingAnchor, constant: 15),
                abilityCell.centerXAnchor.constraint(equalTo: abilitiesStackView.centerXAnchor),
                abilityCell.topAnchor.constraint(equalTo: lastAbility?.bottomAnchor ?? abilitiesStackView.topAnchor, constant: lastAbility == nil ? 15 : 10)
            ])
            lastAbility = abilityCell
        }
        
        let initialAndFinalSpacing : CGFloat = 15*2
        let listSpacing : CGFloat = 10
        let cellHeight: CGFloat = lastAbility?.cellHeight ?? 0
        
        NSLayoutConstraint.activate([
            abilitiesStackView.heightAnchor.constraint(equalToConstant: CGFloat(initialAndFinalSpacing + cellHeight * CGFloat(abilities.count) + listSpacing * CGFloat(abilities.count - 1)))
        ])
    }
    
    func addConstraints(){
        var constraints : [NSLayoutConstraint] = []
        
        // myView
        constraints.append(myView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(myView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(myView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(myView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        // topView
        constraints.append(topView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(topView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        constraints.append(topView.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(topView.heightAnchor.constraint(equalTo: myView.heightAnchor, multiplier: 0.15))
        
        
        // infoView
        constraints.append(infoView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 10))
        constraints.append(infoView.centerYAnchor.constraint(equalTo: topView.centerYAnchor))
        
        constraints.append(infoView.heightAnchor.constraint(equalTo: topView.heightAnchor))
        constraints.append(infoView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.65))
        
        
        // SCROLL VIEW
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        
        // ABILITIES TITLE
        constraints.append(abilitiesTitle.topAnchor.constraint(equalTo: scrollView.topAnchor))
        constraints.append(abilitiesTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor))
        
        // ABILITIES STACK VIEW
        constraints.append(abilitiesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15))
        constraints.append(abilitiesStackView.topAnchor.constraint(equalTo: abilitiesTitle.bottomAnchor, constant: 15))
        constraints.append(abilitiesStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor))
        
        // STATS TITLE
        constraints.append(statsTitle.topAnchor.constraint(equalTo: abilitiesStackView.bottomAnchor, constant: 20))
        constraints.append(statsTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor))
        
        // STATS STACK VIEW
        constraints.append(statsStackView.topAnchor.constraint(equalTo: statsTitle.bottomAnchor, constant: 15))
        constraints.append(statsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15))
        constraints.append(statsStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor))
        
        
        NSLayoutConstraint.activate(constraints)
    }
}


class AbilityCell : UIView {
    
    let cellHeight = CGFloat(30)
    var isHiddenAbility : Bool = false
    
    let hiddenAbilityView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        view.squircle()
        let label = UILabel()
        label.text = "Hidden"
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        return label
    }()
    
    init(name: String, hidden: Bool = false){
        self.nameLabel.text = name
        self.isHiddenAbility = hidden
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        squircle()
        PrepareDetails()
    }
    
    func PrepareDetails(){
        addSubview(nameLabel)
        addSubview(hiddenAbilityView)
        hiddenAbilityView.isHidden = !isHiddenAbility
        addConstraints()
    }
    
    func addConstraints() {
        var constraints : [NSLayoutConstraint] = []
        constraints.append(heightAnchor.constraint(equalToConstant: cellHeight))
        constraints.append(nameLabel.centerYAnchor.constraint(equalTo:centerYAnchor))
        constraints.append(nameLabel.centerXAnchor.constraint(equalTo:centerXAnchor))
        
        constraints.append(hiddenAbilityView.leadingAnchor.constraint(equalTo:leadingAnchor))
        constraints.append(hiddenAbilityView.heightAnchor.constraint(equalTo: heightAnchor))
        constraints.append(hiddenAbilityView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class StatCell : UIView {
    
    let textBackgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.squircle()
        return view
    }()
    
    let cellHeight = CGFloat(30)
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        return label
    }()
    
    let valueLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        return label
    }()
    
    init(name: String, value: Int){
        self.nameLabel.text = name
        self.valueLabel.text = String(value)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        squircle()
        setupHierarchy()
        addConstraints()
    }
    
    func setupHierarchy(){
        addSubview(textBackgroundView)
        addSubview(nameLabel)
        addSubview(valueLabel)
    }
    
    func addConstraints() {
        var constraints : [NSLayoutConstraint] = []
        constraints.append(heightAnchor.constraint(equalToConstant: cellHeight))
        
        constraints.append(textBackgroundView.heightAnchor.constraint(equalTo: heightAnchor))
        
        constraints.append(nameLabel.centerYAnchor.constraint(equalTo:centerYAnchor))
        constraints.append(nameLabel.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 10))
        
        constraints.append(valueLabel.centerYAnchor.constraint(equalTo:centerYAnchor))
        constraints.append(valueLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -15))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
