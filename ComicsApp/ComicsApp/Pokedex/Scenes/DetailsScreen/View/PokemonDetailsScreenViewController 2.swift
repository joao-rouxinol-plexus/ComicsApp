////
////  Untitled.swift
////  ComicsApp
////
////  Created by Duarte Miguel Charrua Silva on 21/03/2025.
////
//
//
//import Foundation
//import UIKit
//
//class PokemonDetailsScreenViewControllerOLD: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCellTableViewCell.identifier, for: indexPath) as? PokeCellTableViewCell else {
//            print("will not be setting up cell")
//            return UITableViewCell()
//        }
//        print("setting up cell")
//        cell.setupCell(viewModel: listViewModel)
//        cell.selectionStyle = .none
//        cell.backgroundColor = cell.backgroundColor?.lighter(by: 0.2)
//        return cell
//    }
//    
//    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        view.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        //        myView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        //        scrollView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        //        myView.backgroundColor = .white
//        //        scrollView.backgroundColor = .white
//    }
//    
//    var viewModel : PokemonViewModel
//    var listViewModel : PokemonListViewModel
//    
////    private let name: UILabel = {
////        let textField = UILabel()
////        textField.translatesAutoresizingMaskIntoConstraints = false
////        textField.textColor = .label
////        textField.textAlignment = .center
////        textField.font = .systemFont(ofSize: 20, weight: .bold)
////        return textField
////    }()
//    
//    private let imageView : UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let myView : UIView = {
//        let myView = UIView()
//        myView.translatesAutoresizingMaskIntoConstraints = false
//        return myView
//    }()
//    
//    private let tableView : UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//    
//    
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentSize = CGSize(width: 300, height: 1000)
//        return scrollView
//    }()
//    
//    
//    init(pokemonViewModel: PokemonViewModel, pokemonListViewModel: PokemonListViewModel){
//        self.viewModel = pokemonViewModel
//        listViewModel = pokemonListViewModel
//        super.init(nibName: nil, bundle: nil)
//        self.PrepareDetails(pokemonListViewModel)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func PrepareDetails(_ pokemonListViewModel: PokemonListViewModel){
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.rowHeight = 120
//        tableView.showsVerticalScrollIndicator = false
//        
//        tableView.register(PokeCellTableViewCell.register(), forCellReuseIdentifier: PokeCellTableViewCell.identifier)
//        
//        tableView.reloadData()
//        
//        
//        
//        print("pokemonListViewModel.name: \(pokemonListViewModel.pokemon)")
//        myView.addSubview(tableView)
//        
//        
////        name.text = viewModel.name
//        view.addSubview(myView)
//        myView.addSubview(scrollView)
//        
//        imageView.sd_setImage(with: URL(string: viewModel.shinyCorrectedSprite)){_,_,_,_ in
//            let image: UIImage = self.imageView.image ?? UIImage()
//            self.myView.backgroundColor = image.dominantColor()
//            
//            self.tableView.backgroundColor = self.myView.backgroundColor!.lighter(by: 0.2)
//            self.scrollView.backgroundColor = self.myView.backgroundColor!.lighter(by: 0.2)
//        }
//        self.addConstraints()
//        tableView.reloadData()
//    }
//    
//    func addConstraints(){
//        var constraints : [NSLayoutConstraint] = []
//        
//        // myView
//        constraints.append(myView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
//        constraints.append(myView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
//        constraints.append(myView.topAnchor.constraint(equalTo: view.topAnchor))
//        constraints.append(myView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
//        
//        // topView
//        constraints.append(tableView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor))
//        constraints.append(tableView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor))
//        constraints.append(tableView.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor))
//        constraints.append(tableView.heightAnchor.constraint(equalToConstant: 120))
//        
//        
//        // SCROLL VIEW
//        constraints.append(scrollView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor))
//        constraints.append(scrollView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor))
//        constraints.append(scrollView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10))
//        constraints.append(scrollView.bottomAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.bottomAnchor))
//        
//        
//        
//        NSLayoutConstraint.activate(constraints)
//        
//    }
//    
//    
//    
//}
