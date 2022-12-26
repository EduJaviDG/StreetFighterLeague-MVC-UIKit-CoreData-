//
//  AttributesMethods.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 4/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import Foundation

class AttributesMethods {
    
    func imageCharacters(name character: String) -> String{
        
        let _value: String = character.lowercased().trimmingCharacters(in: .whitespaces)
        
        let value = _value.replacingOccurrences(of: "-", with: "")
        
        return Fighters.listOfFighters(fighter: value)
        
    }
    
    
    func flatCountry(name country: String) -> String? {
        
        let flatsList = ["poland":"🇲🇨","usa":"🇺🇸","eeuu":"🇺🇸","spain":"🇪🇸","korea":"🇰🇷"]
        
        guard let flat = flatsList[country] else {
            
            return country.capitalized
            
        }
        
        return flat
        
    }
    
    
    func levelOfPlayer(level value: Int) -> String{
        
        switch value {
            
        case 1...50 : return "⭐️"
            
        case 50...100 : return "⭐️⭐️"
            
        case 100...500: return "⭐️⭐️⭐️"
            
        case 500...1000: return "⭐️⭐️⭐️⭐️"
            
        case 1000...9999: return "⭐️⭐️⭐️⭐️⭐️"
            
        default: return ""
            
        }
        
    }
    
    func playersOrdered(players list: [Player])-> [Player] {
        
        let listOrdered = list.sorted(by: {$0.points > $1.points})
        
        return listOrdered
        
        
    }
    
    
    
}
