//
//  ExtensionAlertController.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 4/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController{
    
    /// Alert Save
    
    func saveDataAlert(view: UIViewController, players saveList: [Player], completion: @escaping ([Player]) -> ()) {
        
        var tempList = saveList
        
        let alertAction = UIAlertAction()
        
        let placeholdersList = ["Name","Country","Characters","Points","Profile image from URL"]
        
        let saveAlert = UIAlertController(title: "New Player", message: "Add New Player", preferredStyle: .alert)
        
        placeholdersList.forEach { item in
            
            saveAlert.addTextField(configurationHandler: {(textfield:UITextField) -> Void in
                
                if item == "Points" {
                    
                    textfield.keyboardType = .decimalPad
                    
                }
                
                textfield.placeholder = item
                
                //textfield.addTarget(self, action: #selector(validate.validateNewPlayer), for: .editingChanged)
                
            })
            
        }
        
        
        let saveData = alertAction.saveAction(view: view, saveAlert: saveAlert,
            players: tempList){ (list) in
            
                completion(list)
            
            }
        
        saveData.isEnabled = false
        
        let saveCancelData = alertAction.cancelAction()
        
        let validate = Validate()
        
        validate.observeTextFieldSave(textfield: saveAlert.textFields![0] , alert: saveAlert, saveData: saveData)
        
        validate.observeTextFieldSave(textfield: saveAlert.textFields![1] , alert: saveAlert, saveData: saveData)
        
        validate.observeTextFieldSave(textfield: saveAlert.textFields![2] , alert: saveAlert, saveData: saveData)
        
        validate.observeTextFieldSave(textfield: saveAlert.textFields![3] , alert: saveAlert, saveData: saveData)
        
        validate.observeTextFieldSave(textfield: saveAlert.textFields![4] , alert: saveAlert, saveData: saveData)
        
        saveAlert.addAction(saveData)
        
        saveAlert.addAction(saveCancelData)
        
        DispatchQueue.main.async {
            
            view.present(saveAlert, animated: false, completion: nil)
            
        }
        
        
    }
    
    /// Alert Update
    
    func UpdateDataAlert(view: UIViewController, player name: String, navigationController: UINavigationController) {
        
        let alertAction = UIAlertAction()
        
        let placeholdersList = ["Name","Country","Characters","Points","Profile image from URL"]
        
        let updateAlert = UIAlertController(title: "Update", message: "Update Player", preferredStyle: .alert)
        
        let updateData = alertAction.updateAction(updateAlert: updateAlert, player: name, navigation: navigationController )
        
        
        placeholdersList.forEach { item in
            
            updateAlert.addTextField(configurationHandler: {(textfield:UITextField) -> Void in
                
                if item == "Points" {
                    
                    textfield.keyboardType = .decimalPad
                    
                }
                
                textfield.placeholder = item
                
                //textfield.addTarget(self, action: #selector(validate.validateUpdatePlayer), for: .editingChanged)
                
            })
        }
        
        updateData.isEnabled = false
        
        let updateCancelData = UIAlertAction(title: "Cancel", style: .cancel)
        
        let validate = Validate()
        
        validate.observeTextFieldUpdate(textfield: updateAlert.textFields![0], alert: updateAlert, saveUpdate: updateData)
        
        validate.observeTextFieldUpdate(textfield: updateAlert.textFields![1], alert: updateAlert, saveUpdate: updateData)
        
        validate.observeTextFieldUpdate(textfield: updateAlert.textFields![2], alert: updateAlert, saveUpdate: updateData)
        
        validate.observeTextFieldUpdate(textfield: updateAlert.textFields![3], alert: updateAlert, saveUpdate: updateData)
        
         validate.observeTextFieldUpdate(textfield: updateAlert.textFields![4], alert: updateAlert, saveUpdate: updateData)
        
        updateAlert.addAction(updateData)
        
        updateAlert.addAction(updateCancelData)
        
        DispatchQueue.main.async {
            
            view.present(updateAlert, animated: false, completion: nil)
            
        }
        
    }
    
    /// Delete Alert
    
    func deleteDataAlert(view: UIViewController, player name: String, navigationController: UINavigationController) {
        
        let alertAction = UIAlertAction()
        
        let deleteAlert = UIAlertController(title: "Warning!⚠️", message: "Are you sure to delete? ", preferredStyle: .alert)
        
        let deleteData = alertAction.deleteAction(player: name, navigation: navigationController)
        
        let deleteCancelData = alertAction.cancelAction()
        
        deleteAlert.addAction(deleteData)
        
        deleteAlert.addAction(deleteCancelData)
        
        DispatchQueue.main.async {
            
            view.present(deleteAlert, animated: false, completion: nil)
            
        }
        
    }
    
}

