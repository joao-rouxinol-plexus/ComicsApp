//
//  PokeDexMainScreenViewController.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.

import UIKit
import SDWebImage

class PokeDexMainScreenViewController: UIViewController {
    
    var viewModel: PokemonMainViewModel = PokemonMainViewModel()
    private var originalNavigationBar: UINavigationBarAppearance?
    
    private let pokemonTableView: UITableView = {
        let PokemonTableView = UITableView()
        PokemonTableView.translatesAutoresizingMaskIntoConstraints = false
        return PokemonTableView
    }()
    
    private let backToTopButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "chevron.up")
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.alpha = 0.75
        button.backgroundColor = .systemBackground
        let size = 60.0
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: size),
            button.widthAnchor.constraint(equalToConstant: size),
        ])
        button.layer.cornerRadius = size / 2
        button.clipsToBounds = true
        
        return button
    }()
    
    @objc private func handleBackToTop() {
        DispatchQueue.main.async {
            self.pokemonTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backToTopButton.addTarget(self, action: #selector(handleBackToTop), for: .touchUpInside)
        viewModel.getList(position: listNav.first){
            self.setupTableView()
        }
        view.addSubview(pokemonTableView)
        view.addSubview(backToTopButton)
        addConstraints()
        self.title = "Pokémon List"
        if let navBar = navigationController?.navigationBar {
            originalNavigationBar = navBar.standardAppearance
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController {
            
            navigationController.navigationBar.prefersLargeTitles = false
            navigationController.navigationBar.tintColor = .red
            
            if let appearance = originalNavigationBar {
                appearance.configureWithOpaqueBackground()
                navigationController.navigationBar.standardAppearance = appearance
                navigationController.navigationBar.scrollEdgeAppearance = appearance
                navigationController.navigationBar.compactAppearance = appearance
            }
        }
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            pokemonTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokemonTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokemonTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backToTopButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            backToTopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func OpenPokemonDetails(for pokemon: PokemonViewModel){
        DispatchQueue.main.async {
            let controller = PokemonDetailsScreenViewController(pokemonViewModel: pokemon)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension PokeDexMainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCellTableViewCell.identifier, for: indexPath) as? PokeCellTableViewCell else {
            return UITableViewCell()
        }
        
        backToTopButton.isHidden = indexPath.row <= 10
        
        if ((viewModel.pokemons.count - indexPath.row) == (viewModel.pageLimit/2)){
            self.viewModel.getList(position: listNav.next) {
                DispatchQueue.main.async { [weak self] in
                    self?.reloadTableView()
                }
            }
        }
        
        cell.setupCell(viewModel: viewModel.pokemons[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.pokemons[indexPath.row].url
        OpenPokemonDetails(for: viewModel.getPokemonData(url)!)
    }
    
    func reloadTableView() {
        pokemonTableView.reloadData()
    }
    
    func setupTableView() {
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        pokemonTableView.rowHeight = 120
        pokemonTableView.showsVerticalScrollIndicator = false
        registerCells()
    }
    
    func registerCells() {
        self.pokemonTableView.register(PokeCellTableViewCell.self, forCellReuseIdentifier: PokeCellTableViewCell.identifier)
    }
    
}
