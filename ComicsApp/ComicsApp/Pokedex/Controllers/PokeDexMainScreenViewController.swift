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
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
            }
        }
        
        cell.setupCell(viewModel: viewModel.pokemons[indexPath.row], indexPath: indexPath)
        cell.selectionStyle = .none
        
        return cell
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
        self.PokemonTableView.register(PokeCellTableViewCell.register(), forCellReuseIdentifier: PokeCellTableViewCell.identifier)
    }
}

import CoreImage
import CoreImage.CIFilterBuiltins

extension UIImage {
    func dominantColor() -> UIColor? {
        
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let filter = CIFilter.areaAverage()
        filter.inputImage = inputImage
        filter.extent = inputImage.extent
        
        let context = CIContext(options: [CIContextOption.workingColorSpace: CGColorSpaceCreateDeviceRGB()])
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )
        
        let alpha = CGFloat(bitmap[3]) / 255.0
        let red = alpha > 0 ? CGFloat(bitmap[0]) / 255.0 / alpha : 0
        let green = alpha > 0 ? CGFloat(bitmap[1]) / 255.0 / alpha : 0
        let blue = alpha > 0 ? CGFloat(bitmap[2]) / 255.0 / alpha : 0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
