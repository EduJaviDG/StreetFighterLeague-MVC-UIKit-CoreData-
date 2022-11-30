//
//  MyCustomAlert.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 29/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

class MyCustomAlert: NSObject {

    var placeholdersList: [String]?
    
    var saveData: UIAlertAction?
    
    var cancelData: UIAlertAction?
    
    var alert: UIAlertController?
    
    private var savePlayer: Player?
    
    private var _playerList: [Player]?
    

    func initCustomAlert(view: UIViewController,  player list: [Player], completion: @escaping ([Player]) -> ()) {
        
        var _list = list
        
        self.placeholdersList = ["Name","Country","Characters","Points","Profile image from URL"]
        
        alert = UIAlertController(title: "New Player", message: "Add New Player", preferredStyle: .alert)
        
        self.placeholdersList!.forEach { item in
            
            alert!.addTextField(configurationHandler: {(textfield:UITextField) -> Void in
                
                if item == "Points" {
                    
                    textfield.keyboardType = .decimalPad
                    
                }
                
                textfield.placeholder = item
              
                
            })
        }
        
        self.saveData = UIAlertAction(title: "Save", style: .default, handler: {(action:UIAlertAction) -> Void in
            
            guard let textFieldName = self.alert!.textFields![0] as? UITextField,
                let nameToSave = textFieldName.text else{
                    

                    
                    return
            }
            guard let textFieldCountry = self.alert!.textFields![1] as? UITextField,
                let countryToSave = textFieldCountry.text else{
                    
                    return
            }
            
            guard let textFieldCharacters = self.alert!.textFields![2] as? UITextField,
                let charactersToSave = textFieldCharacters.text else{
                    
                    return
            }
            
            guard let textFieldPoints = self.alert!.textFields![3] as? UITextField,
                let pointsToSave = textFieldPoints.text else{
                    
                    return
            }
            
            guard let textFieldProfile = self.alert!.textFields![4] as? UITextField,
                let profileToSave = textFieldProfile.text else{
                    
                    return
            }
            
            self.savePlayer = Player(name: nameToSave, country: countryToSave, characters: charactersToSave, points: Int(pointsToSave) ?? 0, profile:profileToSave , imageCharcaters: charactersToSave)
            
            _list.append(self.savePlayer!)
            
            completion(_list)
            
        })
        
        self.saveData?.isEnabled = false
        self.cancelData = UIAlertAction(title: "Cancel", style: .cancel)
        
        observeTextFieldIsEmpty(textfield: (self.alert!.textFields?[0])!)
        
        observeTextFieldIsEmpty(textfield: (self.alert!.textFields?[1])!)
        
        observeTextFieldIsEmpty(textfield: (self.alert!.textFields?[2])!)
        
        observeTextFieldIsEmpty(textfield: (self.alert!.textFields?[3])!)

        
        self.alert!.addAction(self.saveData!)
        
        self.alert?.addAction(self.cancelData!)
        
        DispatchQueue.main.async {
            
            view.present(self.alert!, animated: false, completion: nil)
            
        }
        
        
        
    }
    
    private func observeTextFieldIsEmpty(textfield: UITextField){
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textfield, queue: OperationQueue.main) { (notification) -> Void in
            
            let textFieldName = self.alert!.textFields?[0] as? UITextField
            
            let textFieldCountry = self.alert!.textFields![1] as? UITextField
            
            let textFieldCharacters = self.alert!.textFields![2] as? UITextField
            
            let textFieldPoints = self.alert!.textFields![3] as? UITextField
            
            self.saveData?.isEnabled = !textFieldName!.text!.isEmpty && !textFieldCountry!.text!.isEmpty &&                    !textFieldCharacters!.text!.isEmpty && !textFieldPoints!.text!.isEmpty
        }
        
    }
    
}
