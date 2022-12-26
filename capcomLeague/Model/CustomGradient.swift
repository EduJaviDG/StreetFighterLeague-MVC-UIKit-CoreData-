//
//  Gradient.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 30/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit
 class CustomGradient {
    
    func getGradientLayer(bounds:CGRect, startX:Double, endX:Double, startY:Double, endY:Double) -> CAGradientLayer{
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        // gradient colors in order which they will visually appear
        gradient.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.white.cgColor]
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: startX, y: startY)
        gradient.endPoint = CGPoint(x: endX, y: endY)
        return gradient
    }
    
    func gradientColor(bounds:CGRect, gradientLayer:CAGradientLayer) -> UIColor? {
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image!)
    }
    

}
