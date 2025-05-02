//
//  MainViewController+TableView.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//

import Foundation
import UIKit

extension MarvelMainScreenViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Setup
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .backgroundColor
        self.registerCells()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        self.bindViewModel()
    }
    
    func registerCells() {
        MarvelMainCharacterCell.register(with: tableView)
    }
    
    func setupButton() {
        if topButton == nil {
            topButton = UIButton(type: .system)
            topButton.setImage(UIImage(named: "marvelTop")?.withRenderingMode(.alwaysOriginal), for: .normal)
            topButton.imageView?.contentMode = .scaleAspectFit
            topButton.addTarget(self, action: #selector(handleTopButton), for: .touchUpInside)
            topButton.backgroundColor = .topButtonColor
            topButton.layer.cornerRadius = 25
            topButton.addBorder(color: .systemYellow, width: 1)
            topButton.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(topButton)
            
            topButton.accessibilityLabel = "Go to the top"
            topButton.accessibilityTraits = .button
            
            NSLayoutConstraint.activate([
                topButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
                topButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                topButton.widthAnchor.constraint(equalToConstant: 50),
                topButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        topButton.isHidden = true
    }
    
    // MARK: - Buttons
    @objc func handleTopButton() {
        DispatchQueue.main.async {
            self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
        return inSearchMode ? (viewModel.cellDataSource.value?.count ?? 0) : (viewModel.dataSource?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarvelMainCharacterCell.identifier, for: indexPath) as? MarvelMainCharacterCell else { return UITableViewCell()}
        let cellViewModel = viewModel.cellDataSource.value?[indexPath.row]
        
        if let cellViewModel = cellViewModel {
            cell.setUpCell(viewModel: cellViewModel)            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = viewModel.cellDataSource.value?[indexPath.row] else { return }
            let detailVC = MarvelDetailViewController()
            detailVC.character = character
            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let topButton = topButton else { return }
        let position = scrollView.contentOffset.y
        if position > 200 {
            if topButton.isHidden {
                topButton.isHidden = false
            }
        } else {
            
            if !topButton.isHidden {
                topButton.isHidden = true
            }
        }
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight ) {
            viewModel.getData(offset: MarvelNetworkConstant.shared.offset)
        }
    }
    
    // MARK: - ViewModel Binding
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self , let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating( )
                }else {
                    self.activityIndicator.stopAnimating()
                    self.setupButton()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] Characters in
            guard let self = self, let Characters = Characters else {
                return
            }
            self.cellDataSource = Characters
            reloadTableView()
        }
        
        func reloadTableView() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
}
