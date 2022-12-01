//
//  ImageViewModified.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 28/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
// https://static.wikia.nocookie.net/genshin-impact/images/2/2b/Character_Ningguang_Thumb.png/revision/latest?cb=20210812050415&path-prefix=id

import UIKit

class ImageViewModified: UIImageView {

}

extension UIImageView{
    
    func downloaded( from url: URL, contentMode mode: ContentMode = .scaleAspectFit){
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                
                else { return }
            DispatchQueue.main.async() {
                
                self.image = self.resizeImage(image: image, targetSize: CGSize(width: 256.0, height: 256.0))
                
            }
            }.resume()
        
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        
        downloaded(from: url, contentMode: mode)
        
        
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
    
}


