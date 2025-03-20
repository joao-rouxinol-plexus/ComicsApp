//
//  File.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 20/03/2025.
//

import Foundation
import UIKit

class ScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let text: UILabel = {
        let textField = UILabel(frame: CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: 60))
        //        textField.textColor = .label
        //        textField.font = .systemFont(ofSize: 17, weight: .medium)
        textField.text = "OOOOOOOOOOO"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 20, weight: .bold)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Profile"
        //          if let navigationController = self.navigationController {
        //              let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //              navigationController.navigationBar.titleTextAttributes = textAttributes
        //          }
        
        //       let gradientLayer = CAGradientLayer()
        //           gradientLayer.frame = view.bounds
        //           gradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor] // Customize the gradient colors as needed
        //           gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // Adjust the start point if needed
        //           gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)   // Adjust the end point if needed
        //           view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(text)
    }
    
}
