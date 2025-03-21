//
//  Untitled.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 21/03/2025.
//


import Foundation
import UIKit

class PokemonDetailsScreenViewController: UIViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        view.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        myView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        scrollView.backgroundColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        myView.backgroundColor = .white
//        scrollView.backgroundColor = .white
    }
    
    var viewModel : PokemonViewModel
    
    private let name: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .label
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        return textField
    }()

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

    private let topView : UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: 300, height: 1000)
        return scrollView
    }()
    
    init(viewModel: PokemonViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.PrepareDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func PrepareDetails(){
        name.text = viewModel.name
        view.addSubview(myView)
        myView.addSubview(topView)
        topView.addSubview(name)
        
        imageView.sd_setImage(with: URL(string: viewModel.sprite)){_,_,_,_ in
            let image: UIImage = self.imageView.image ?? UIImage()
            self.myView.backgroundColor = image.dominantColor()
            
            self.topView.addSubview(self.imageView)
            self.topView.backgroundColor = self.myView.backgroundColor!.lighter(by: 0.2)
            self.scrollView.backgroundColor = self.myView.backgroundColor!.lighter(by: 0.2)
        }
        
        
        myView.addSubview(scrollView)


        
        addConstraints()
    }
    
    
    func addConstraints(){
        var constraints : [NSLayoutConstraint] = []
            
        // myView
        constraints.append(myView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(myView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(myView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(myView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
            // topView
            constraints.append(topView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(topView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(topView.topAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.topAnchor))
            constraints.append(topView.heightAnchor.constraint(equalToConstant: 150))
        
                // Image
                constraints.append(imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20))
                constraints.append(imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor))
                constraints.append(imageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.6))
                constraints.append(imageView.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.6))
                
            // SCROLL VIEW
            constraints.append(scrollView.leadingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.leadingAnchor))
            constraints.append(scrollView.trailingAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.trailingAnchor))
            constraints.append(scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10))
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: myView.safeAreaLayoutGuide.bottomAnchor))
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
