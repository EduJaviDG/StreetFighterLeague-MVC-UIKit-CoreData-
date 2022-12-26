//
//  ExtensionAlertAction.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 4/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertAction{
    
    func saveAction(view: UIViewController, saveAlert: UIAlertController, players list: [Player],
                    completion: @escaping ([Player]) -> ()) -> UIAlertAction {
        
        var tempList = list
        
        let dao = Dao()
        
        let action = UIAlertAction(title: "Save", style: .default, handler: {(action:UIAlertAction) -> Void in
            
            guard let textFieldName = saveAlert.textFields![0] as? UITextField,
                let nameToSave = textFieldName.text else{
                    
                    return
            }
            guard let textFieldCountry = saveAlert.textFields![1] as? UITextField,
                let countryToSave = textFieldCountry.text else{
                    
                    return
            }
            
            guard let textFieldCharacters = saveAlert.textFields![2] as? UITextField,
                let charactersToSave = textFieldCharacters.text else{
                    
                    return
            }
            
            guard let textFieldPoints = saveAlert.textFields![3] as? UITextField,
                let pointsToSave = textFieldPoints.text else{
                    
                    return
            }
            
            guard let textFieldProfile = saveAlert.textFields![4] as? UITextField,
                let profileToSave = textFieldProfile.text else{
                    
                    return
            }
            
            if !dao.duplicatedEntity(player: nameToSave) {
                
                let updateList = dao.saveEntity(nameToSave, countryToSave, charactersToSave, Int(pointsToSave)!, profileToSave, &tempList)
                
                completion(updateList)
                
                } else {
                
                Toast.show(message: "Sorry player name is already taken!", controller: view)
                
                }
            
        })
        
        return action
        
    }
    
    func updateAction(updateAlert: UIAlertController, player name: String, navigation: UINavigationController) -> UIAlertAction {
        
        let dao = Dao()
        
        let action = UIAlertAction(title: "Update", style: .default, handler: {(action:UIAlertAction) -> Void in
            
            guard let textFieldName = updateAlert.textFields![0] as? UITextField,
                let nameToSave = textFieldName.text else{
                    
                    return
            }
            guard let textFieldCountry = updateAlert.textFields![1] as? UITextField,
                let countryToSave = textFieldCountry.text else{
                    
                    return
            }
            
            guard let textFieldCharacters = updateAlert.textFields![2] as? UITextField,
                let charactersToSave = textFieldCharacters.text else{
                    
                    return
            }
            
            guard let textFieldPoints = updateAlert.textFields![3] as? UITextField,
                let pointsToSave = textFieldPoints.text else{
                    
                    return
            }
            
            guard let textFieldProfile = updateAlert.textFields![4] as? UITextField,
                let profileToSave = textFieldProfile.text else{
                    
                    return
            }
            
            dao.updateEntity(player: name, updateName: nameToSave, updateCountry: countryToSave, updateCharacters: charactersToSave, updatePoints: pointsToSave, updateProfile: profileToSave)
            
            navigation.popToRootViewController(animated: true)
            
        })
        
        return action
        
    }
    
    func deleteAction (player name: String, navigation: UINavigationController) -> UIAlertAction {
        
        let dao = Dao()
        
        let action = UIAlertAction(title: "Delete", style: .default, handler: { (action:UIAlertAction) -> Void in
            
            dao.deleteEntity(player: name)
            
            navigation.popToRootViewController(animated: true)
            
        })
        
        return action
        
    }
    
    func cancelAction() -> UIAlertAction {
        
        return UIAlertAction(title: "Cancel", style: .cancel)
        
    }
    
    
}
