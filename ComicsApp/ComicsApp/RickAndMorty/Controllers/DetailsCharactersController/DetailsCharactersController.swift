//
//  DetailsCharactersController.swift
//  ComicsApp
//
//  Created by Diogo Alexandre Pereira on 27/3/25.
//

import UIKit

class DetailsCharactersController: UIViewController {
    
    let view1 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Character Details"
        
        view1.backgroundColor = .systemBlue
        view1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view1.center = view.center
        view.addSubview(view1)
    }
    
}
