//
//  ViewDetailController.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 27/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

import Foundation

class ViewDetailController: UIViewController {
    
    @IBOutlet weak var imageProfile: ImageViewModified!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelCountry: UILabel!
    
    @IBOutlet weak var labelCharecter: UILabel!
    
    @IBOutlet weak var labelDetailPoints: UILabel!
    
    let manager = ManegerUserDefaults()
    
    let KEY_MANAGER = "capcom"
    
    let TITLLE = "Warning"
    
    let MESSAGE = "Access key does not exist in our records"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDetail()
      
    }
    
    private func initializeDetail(){
        
       let player = manager.recoverData(key: KEY_MANAGER)
        
        if player.name.isEmpty {
            
            manager.alertView(view:self, title: TITLLE, message: MESSAGE)
        }
        
        imageProfile.downloaded(from: player.profile)
        
        labelName.text! = player.name
        
        labelCountry.text! = player.flatCountry(name: player.country.lowercased())!
        
        labelCharecter.text! = player.characters.capitalized
        
        labelDetailPoints.text! = String(player.points)
        
    }

}
