//
//  ExternalDataManager.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 14/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import Foundation


class ExternalDataManager {
    
    private let baseUrl = "https://restcountries.com/v3.1/name/"
    
    func getCountry (path value: String, completion: @escaping (String?)->()){
        
        let url = URL(string: "\(self.baseUrl)\(value)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let json = data else {return}
            
            if let httppURLResponse = response as? HTTPURLResponse, httppURLResponse.statusCode == 200 {
                
                do{
                    
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode([Country].self, from: json)
                    
                    completion((result.first?.flag))
                    
                    
                    } catch let error as NSError {
                    
                    print("Connection Error = \(error), \(error.userInfo)")
                    
                }
                
                
            }
            
        }.resume()
        
    }
    
}
