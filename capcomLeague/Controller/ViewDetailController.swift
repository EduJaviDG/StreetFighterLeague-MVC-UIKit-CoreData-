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
    
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelCountry: UILabel!
    
    @IBOutlet weak var labelCharecter: UILabel!
    
    @IBOutlet weak var labelLevel: UILabel!
    
    @IBOutlet weak var updateButton: UIButton! {
        
        didSet{
            
            updateButton.addTarget(self, action: #selector(clickUpdateData), for: .touchUpInside)
            
        }
        
    }
    
    @IBOutlet weak var deleteButton: UIButton! {
        
        didSet{
            
            deleteButton.addTarget(self, action: #selector(clickDeleteData), for: .touchUpInside)
            
        }
        
    }
    
    var dataManager: ExternalDataManager!
    
    var flags = [String]()
    
    let manager = ManagerUserDafaults()
    
    let alert = UIAlertController()
    
    let methods = AttributesMethods()
    
    let TITLLE = "Warning"
    
    let MESSAGE = "Access key does not exist in our records"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDetail()
      
    }
    
    private func initializeDetail(){
        
        dataManager = ExternalDataManager()
        
        let player = manager.recoverData(key: KeyChain.KEY_MANAGER_DETAIL.rawValue)
        
        if player.name.isEmpty || player.country.isEmpty || player.characters.isEmpty {
            
            manager.alertView(view: self, title: TITLLE, message: MESSAGE)
            
        }
        
        let country = player.country.lowercased().trimmingCharacters(in: .whitespaces)
        
        dataManager.getCountry(path: country){ (data) in
            
            DispatchQueue.main.async {
            
                self.labelCountry.text! = data ?? country.capitalized
                
            }
            
        }
        
        imageProfile.downloaded(from: player.profile)
        
        labelName.text! = player.name
        
        labelCharecter.text! = player.characters.capitalized
        
        labelLevel.text! = methods.levelOfPlayer(level: Int(player.points))
        
    }
    
    @objc func clickUpdateData(){
        
        guard let playerName = labelName.text else{
            
            return
        }
        
        self.alert.UpdateDataAlert(view: self, player: playerName, navigationController: self.navigationController!)
        
        
        
    }
    
    @objc func clickDeleteData(){
        
        
        guard let playerName = labelName.text else {
            
            return
            
        }
        
        self.alert.deleteDataAlert(view: self, player: playerName, navigationController: self.navigationController!)
        
    }
    

}

    

