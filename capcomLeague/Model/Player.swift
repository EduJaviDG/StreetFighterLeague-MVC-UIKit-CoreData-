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
        
        let flatsList = ["poland":"🇲🇨","eeuu":"🇺🇸","spain":"🇪🇸","korean":"🇰🇷"]
        
        guard let flat = flatsList[country] else {
            
            return ""
            
        }
        
        return flat
        
    }
    
    func imageCharacters(name character: String) -> String{
        
        let imagesCharacters = ["ryu": "https://images.gamebanana.com/img/ico/sprays/ryu_copy_copy.png",
                                "ken": "https://images.gamebanana.com/img/ico/sprays/ken_version_2.png", "chun-li":"https://icons.veryicon.com/png/Game/Street%20Fighter%20IV/Chun%20li.png"]
        
        guard let image = imagesCharacters[character] else {
            
            return "https://d1nxzqpcg2bym0.cloudfront.net/google_play/com.skyjack.fighter/08910c56-2a8b-11e8-b7a1-1d77276e51a5/128x128"
            
        }
        
        return image
        
    }

}
