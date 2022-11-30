//
//  Player.swift
//  capcomLeague
//
//  Created by Eduardo Delgado Guerrero on 28/11/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit

import Foundation

struct Player: Codable {
    
    let name: String
    
    let country: String
    
    let characters: String
    
    let points: Int
    
    let profile: String
    
    let imageCharcaters: String
    
    func flatCountry(name country: String) -> String? {
        
        let flatsList = ["poland":"🇲🇨","usa":"🇺🇸","eeuu":"🇺🇸","spain":"🇪🇸","korea":"🇰🇷"]
        
        guard let flat = flatsList[country] else {
            
            return country
            
        }
        
        return flat
        
    }
    
    func imageCharacters(name character: String) -> String{
        
        let imagesCharacters = ["ryu": "characters_ryu",
                                "ken": "characters_ken", "chun-li": "characters_chun_li"]
        
        guard let image = imagesCharacters[character] else {
            
            return "characters_default"
            
        }
        
        return image
        
    }

}
