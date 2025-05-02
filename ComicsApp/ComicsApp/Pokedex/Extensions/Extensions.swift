//
//  Extensions.swift
//  ComicsApp
//
//  Created by Duarte Miguel Charrua Silva on 04/04/2025.
//

import UIKit
import CoreImage.CIFilterBuiltins

extension UIImage {
    
    func dominantColor(_ returnAlphaValue : CGFloat = 1) -> UIColor? {
        
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
        
        return UIColor(red: red, green: green, blue: blue, alpha: returnAlphaValue)
    }
}

extension UIColor {
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    private func adjust(by percentage: CGFloat) -> UIColor? {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        brightness = max(min(brightness + percentage, 1.0),0.1)
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
}

extension UIView {
    func squircle() {
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

extension UIFont {
    func makeScaleable() -> UIFont {
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: self)
    }
}
