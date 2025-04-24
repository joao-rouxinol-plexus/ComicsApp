//
//  PokeDexMainScreenViewController.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.

import UIKit
import SDWebImage

class PokeDexMainScreenViewController: UIViewController {
    
    var viewModel: PokemonMainViewModel = PokemonMainViewModel()
    
    @IBOutlet weak var PokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getList(position: listNav.first){
            self.setupTableView()
        }
        self.title = "Pokémon List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        if let navigationController = self.navigationController {
            navigationController.navigationBar.tintColor = .red
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        }
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
        PokemonTableView.reloadData()
    }
    
    func setupTableView() {
        PokemonTableView.delegate = self
        PokemonTableView.dataSource = self
        PokemonTableView.rowHeight = 120
        PokemonTableView.showsVerticalScrollIndicator = false
        registerCells()
    }
    
    func registerCells() {
        self.PokemonTableView.register(PokeCellTableViewCell.self, forCellReuseIdentifier: PokeCellTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellWidth = tableView.frame.width
        let aspectRatio: CGFloat = 3.2
        return cellWidth / aspectRatio
    }
}
