//
//  MainViewController+TableView.swift
//  MarvelApp
//
//  Created by Mariana Alexandre Dos Santos on 06/03/2025.
//

import Foundation
import UIKit

extension MarvelMainScreenViewController : UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.registerCells()
        
    }
    
    func registerCells(){
        tableView.register(MainCharacterCell.register(),forCellReuseIdentifier: MainCharacterCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacterCell.identifier, for: indexPath) as? MainCharacterCell else {
//            return UITableViewCell()
//        }
//        
//        let cellViewModel = cellDataSource[indexPath.row]
//        cell.setUpCell(viewModel:cellViewModel)
//        cell.selectionStyle = .none
//        return cell
        
        guard indexPath.row < cellDataSource.count else { return UITableViewCell() }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCharacterCell.identifier, for: indexPath) as? MainCharacterCell else {
                return UITableViewCell()
            }

            let cellViewModel = cellDataSource[indexPath.row]
            cell.setUpCell(viewModel: cellViewModel)
            cell.selectionStyle = .none
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
        
    }
    
    func setupFooterView() {
        
        footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        
        topButton = UIButton(type: .system)
        topButton.setTitle("Top", for: .normal)
        topButton.setTitleColor(.systemYellow, for: .normal)
        topButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        topButton.addTarget(self, action: #selector(handleTopButton), for: .touchUpInside)
        topButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(topButton)
        
        self.tableView.tableFooterView = footerView
        
        NSLayoutConstraint.activate([
            footerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            topButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            topButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
        ])
    }
    
    @objc func handleTopButton() {
        DispatchQueue.main.async {
            self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = cellDataSource[indexPath.row]
        print("Personagem Selecionado: \(selectedCharacter.name)")
        let detailVC = DetailViewController()
        detailVC.character = selectedCharacter
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight ) {
            viewModel.getData(offset: NetworkConstant.shared.offset)
            print(NetworkConstant.shared.offset)
        }
    }
    
}
