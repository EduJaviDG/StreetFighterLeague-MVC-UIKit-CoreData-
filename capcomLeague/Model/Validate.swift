//
//  Validate.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 4/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

class Validate  {
    
    /// Save Validate
    
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
    
    private func validateProfile(_ url: String) -> Bool{
        
        let regex = "(ftp|http|https):\\/\\/(\\w+:{0,1}\\w*@)?(\\S+)(:[0-9]+)?(\\/|\\/([\\w#!:.?+=&%@!\\-\\/]))?"
        
        if !url.isEmpty {
            
            return url.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: url)
            
        }
        
        return true
        
        
    }
    
    /// Update Validate
    
    private func validateUpdateName(_ name: String ) -> Bool{
        
        let regex = "^(?![\\s.]+$)[a-zA-Z\\s.-]{1,10}$"
        
        if !name.isEmpty{
            
            return name.count > 0 && NSPredicate(format: "self matches %@",regex).evaluate(with: name)
            
        }
        
        return true
        
    }
    
    
    private func validateUpdateCountry(_ country: String) -> Bool{
        
        let regex = "^(?![\\s.]+$)[a-zA-Z\\s.]{1,10}$"
        
        if !country.isEmpty{
            
            return country.count > 0  && NSPredicate(format: "self matches %@", regex).evaluate(with: country)
            
            
        }
        
        return true
        
        
    }
    
    private func validateUpdateCharacters(_ characters: String) -> Bool{
        
        let regex = "^(?![\\s.-]+$)[a-zA-Z\\s.-]{1,10}$"
        
        if !characters.isEmpty{
            
            return characters.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: characters)
            
        }
        
        return true
        
        
    }
    
    private func validateUpdatePoints(_ points: String) -> Bool{
        
        let regex = "^\\d{1,4}$"
        
        if !points.isEmpty {
            
            return points.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: points)
            
        }
        
        return true
        
    }
    
    private func validateUpdateProfile(_ url: String) -> Bool{
        
        let regex = "(ftp|http|https):\\/\\/(\\w+:{0,1}\\w*@)?(\\S+)(:[0-9]+)?(\\/|\\/([\\w#!:.?+=&%@!\\-\\/]))?"
        
        if !url.isEmpty {
            
            return url.count > 0 && NSPredicate(format: "self matches %@", regex).evaluate(with: url)
            
        }
        
       return true
        
    }
    
    /// NotificationCenter
    
   func observeTextFieldSave(textfield: UITextField, alert: UIAlertController, saveData: UIAlertAction) {
     
     NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textfield, queue: OperationQueue.main) { (notification) -> Void in
     
         let textFieldName = alert.textFields?[0] as? UITextField
        
         let textFieldCountry = alert.textFields![1] as? UITextField
        
         let textFieldCharacters = alert.textFields![2] as? UITextField
        
         let textFieldPoints = alert.textFields![3] as? UITextField
        
         let textFieldProfile = alert.textFields![4] as? UITextField
        
         let name = textFieldName!.text
        
         let country = textFieldCountry!.text
        
         let characters = textFieldCharacters!.text
        
         let points = textFieldPoints!.text
        
         let profile = textFieldProfile!.text
        
         saveData.isEnabled = self.validateName(name!) && self.validateCountry(country!) &&
            self.validateCharacters(characters!) && self.validatePoints(String(points!)) &&
            self.validateProfile(profile!)
     
        }
        
    }
        
   func observeTextFieldUpdate(textfield: UITextField, alert: UIAlertController, saveUpdate: UIAlertAction) {
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textfield, queue: OperationQueue.main) { (notification) -> Void in
            
            let textFieldName = alert.textFields?[0] as? UITextField
            
            let textFieldCountry = alert.textFields![1] as? UITextField
            
            let textFieldCharacters = alert.textFields![2] as? UITextField
            
            let textFieldPoints = alert.textFields![3] as? UITextField
            
            let textFieldProfile = alert.textFields![4] as? UITextField
            
            let name = textFieldName!.text
            
            let country = textFieldCountry!.text
            
            let characters = textFieldCharacters!.text
            
            let points = textFieldPoints!.text
            
            let profile = textFieldProfile!.text
            
            saveUpdate.isEnabled = self.validateUpdateName(name!) && self.validateUpdateCountry(country!) &&
                self.validateUpdateCharacters(characters!) && self.validateUpdatePoints(String(points!)) && self.validateUpdateProfile(profile!)
            
        }
    
    }

}


