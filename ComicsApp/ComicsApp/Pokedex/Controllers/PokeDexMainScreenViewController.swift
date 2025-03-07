//
//  ViewController.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.


import UIKit
import SDWebImage

class PokeDexMainScreenViewController: UIViewController {
    var viewModel: MainViewModel = MainViewModel()
    
//    @IBOutlet weak var image: UIImageView!
//    @IBOutlet weak var TestLabel: UILabel!

    @IBOutlet weak var PokemonTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world")
        viewModel.getList()
        
        while viewModel.isready == false {
            _ = wait()
        }
        self.setupTableView()
        
    }
    
//    @IBAction func HideButton(_ sender: UIButton) {
//        PokemonTableView.isHidden = !PokemonTableView.isHidden
//    }
//    
//    
//    
//    @IBAction func ReloadButton(_ sender: UIButton) {
//        loadPokemon((Int.random(in: 1...920)))
//    }
    
//    func loadPokemon(_ id: Int) {
//        viewModel.getData(id)
//        viewModel.isready = false
//        
//        while viewModel.isready == false {
//            wait()
//        }
//        let string = "\(viewModel.dataSource!.id) \(viewModel.dataSource!.name) "
//        let urlimage = viewModel.dataSource!.gifURL
//        TestLabel.text = string.split(separator: "-").joined(separator: " ").capitalized
//        self.iamge.sd_setImage(with: urlimage)
//    }
    
}

extension PokeDexMainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCellTableViewCell.identifier, for: indexPath) as? PokeCellTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(viewModel: viewModel.pokemons![indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    
    func setupTableView() {
        self.PokemonTableView.delegate = self
        self.PokemonTableView.dataSource = self
//        self.PokemonTableView.frame = PokemonTableView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.PokemonTableView.rowHeight = 120
//        PokemonTableView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0) // Pure yellow

        self.registerCells()
    }
    
    func registerCells() {
        self.PokemonTableView.register(PokeCellTableViewCell.register(), forCellReuseIdentifier: PokeCellTableViewCell.identifier)
    }

    
}


