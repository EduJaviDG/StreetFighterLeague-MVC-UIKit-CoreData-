//
//  MyCustomAlert.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 29/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

class MyCustomAlert: UIAlertController {

    var placeholdersList: [String]?
    
    var propertiesList: [String]?
    
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
                
                textfield.addTarget(self, action: #selector(self.validateNewPlayer), for: .editingChanged)
                
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
            
            self.propertiesList = [nameToSave, countryToSave, countryToSave, pointsToSave, profileToSave, charactersToSave]
            
            self.savePlayer = Player(name: nameToSave, country: countryToSave, characters: charactersToSave, points: Int(pointsToSave) ?? 0, profile: profileToSave , imageCharacters: charactersToSave)
            
            _list.append(self.savePlayer!)
            
            completion(_list)
            
        })
        
        self.saveData?.isEnabled = false
        
        self.cancelData = UIAlertAction(title: "Cancel", style: .cancel)
        
        self.alert!.addAction(self.saveData!)
        
        self.alert?.addAction(self.cancelData!)
        
        DispatchQueue.main.async {
            
            view.present(self.alert!, animated: false, completion: nil)
            
        }
        
        
    }
    
    @objc private func validateNewPlayer(){
        
       if let name = self.alert?.textFields![0].text, let country = self.alert?.textFields![1].text ,
          let characters = self.alert?.textFields![2].text, let points = self.alert?.textFields![3].text{
        
               saveData?.isEnabled = validateName(name) && validateCountry(country) &&
                validateCharacters(characters) && validatePoints(String(points))
        
        }
       
    }
    
    private func validateName(_ name: String ) -> Bool{
        
        let regex = "^(?![\\s.]+$)[a-zA-Z\\s.-]{1,10}$"
        
        return name.count > 0 && NSPredicate(format: "self matches %@",regex).evaluate(with: name)
        
        
    }
    
    private func validateCountry(_ country: String) -> Bool{
        
        
        let regex = "^(?![\\s.]+$)[a-zA-Z\\s.]{1,10}$"
        
        return country.count > 0  && NSPredicate(format: "self matches %@", regex).evaluate(with: country)
        
        
    }
    
    private func validateCharacters(_ characters: String) -> Bool{
        
        
        let regex = "^(?![\\s.-]+$)[a-zA-Z\\s.-]{1,10}$"
        
        return characters.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: characters)
        
        
    }
    
    private func validatePoints(_ points: String) -> Bool{
        
        let regex = "^\\d{1,4}$"
        
        return points.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: points)
        
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
