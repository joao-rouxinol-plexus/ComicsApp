//
//  AppDelegate.swift
//  ComicsApp
//
//  Created by João Rouxinol on 06/03/2025.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let view = ViewControllerView(viewModel: ViewControllerViewModel())
        let viewModel = ViewControllerViewModel()
        let rootVC = ViewController(detailView: view, viewModel: viewModel)
        let nav = UINavigationController(rootViewController: rootVC)
        
        viewModel.navigationController = nav
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = nav
        window.makeKeyAndVisible()
                
        self.window = window
        
        return true
    }
}
