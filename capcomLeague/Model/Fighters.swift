//
//  EnumFighters.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 14/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import Foundation

struct Fighters {
    
    static func listOfFighters(fighter name: String) -> String {
        
        let list = ["ryu":"characters_ryu", "ken":"characters_ken", "guile":"characters_guile", "balrog": "characters_balrog", "zangief":"characters_zangief", "dhalsim":"characters_dhalsim", "blanka":"characters_blanka", "vega":"characters_vega", "honda":"characters_honda", "sagat":"characters_sagat", "bison":"characters_bison", "feilong":"characters_fei_long",
            "deejay":"characters_dee_jay", "akuma":"characters_akuma", "camy":"characters_camy",
            "chunli": "characters_chun_li", "defaultFighter":"characters_default"]
        
        guard let fighter = list[name] else {
            
            return list["defaultFighter"]!
            
        }
        
        return fighter
        
    }

    
}
