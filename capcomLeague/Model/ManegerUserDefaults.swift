//
//  ManegerUserDefaults.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 28/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

import Foundation

class ManegerUserDefaults: NSObject {
    
    var data: Data?
    
    func saveData(player: Player , key: String = "capcom"){
        
        let encoder = JSONEncoder()
        
        do{
            
            data = try encoder.encode(player)
            
        }catch{
            
            print("Unable to Encode Player (\(error))")
            
        }
        
        UserDefaults.standard.set(data, forKey: key)
        
        UserDefaults.standard.synchronize()
        
        
        
    }
    
    func recoverData(key: String)-> Player {
        
        var player: Player!
        
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {
            
            return Player(name: "", country: "", characters: "", points: 0, profile: "", imageCharacters: "")
        }
        
        
        do{
            
            let decoder = JSONDecoder()
            
            player = try decoder.decode( Player.self,from: data)
            
        }catch{
            
            print("Unable to Encode Player (\(error))")
            
        }
        
        
        return player
    }
    
    
    func alertView(view: UIViewController, title: String, message: String){
        
         let alert = UIAlertController (title: title, message: message , preferredStyle: .alert)
        
         let defaultAction = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(defaultAction)
        
        DispatchQueue.main.async {
            
            view.present(alert, animated: false, completion: nil)
            
        }
        
        
    }
    

}
