//
//  ViewController.swift
//  testeapipokemon
//
//  Created by Duarte Miguel Charrua Silva on 06/03/2025.


import UIKit
import SDWebImage

class PokeDexMainScreenViewController: UIViewController {
    
    
    
    var viewModel: MainViewModel = MainViewModel()
    var currentPage = 0
    
    
    @IBOutlet weak var PreviousButtonOutlet: UIButton!
    @IBOutlet weak var NextButtonOutlet: UIButton!
    @IBOutlet weak var PokemonTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getList(position: listNav.first)
        
        while viewModel.isready == false {
            _ = wait()
        }
        self.setupTableView()
        
        checkAvailableButton()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                previous()
            case .left:
                next()
            default:
                break
            }
        }
    }
    
    @IBAction func NextButton(_ sender: UIButton) {
        next()
    }
    
    func next(){
        currentPage += 1
        viewModel.getList(position: listNav.next)
        
        while viewModel.isready == false {
            _ = wait()
        }
        
        self.reloadTableView()
        
        checkAvailableButton()
        
    }
    
    
    @IBAction func PreviousButton(_ sender: UIButton) {
        previous()
    }
    
    func previous(){
        currentPage -= 1
        viewModel.getList(position: listNav.previous)
        
        while viewModel.isready == false {
            _ = wait()
        }
        self.reloadTableView()
        
        checkAvailableButton()
    }
    
    func checkAvailableButton() {
        if viewModel.previous == nil {
            PreviousButtonOutlet.isEnabled = false
        }
        else {
            PreviousButtonOutlet.isEnabled = true
        }
        
        if viewModel.next == nil {
            NextButtonOutlet.isEnabled = false
        }
        else {
            NextButtonOutlet.isEnabled = true
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
        cell.setupCell(viewModel: viewModel.pokemons![indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func reloadTableView() {
        PokemonTableView.reloadData()
        PokemonTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    func setupTableView() {
        self.PokemonTableView.delegate = self
        self.PokemonTableView.dataSource = self
        self.PokemonTableView.rowHeight = 120
        self.registerCells()
    }
    
    func registerCells() {
        self.PokemonTableView.register(PokeCellTableViewCell.register(), forCellReuseIdentifier: PokeCellTableViewCell.identifier)
    }
    
}


