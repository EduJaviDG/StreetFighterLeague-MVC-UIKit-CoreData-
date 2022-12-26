//
//  Dao.swift
//  capcomLeagueRf
//
//  Created by Eduardo Delgado Guerrero on 4/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//

import UIKit
import CoreData

class Dao {
    
    /// SaveEntity
    
    func saveEntity(_ name: String, _ country: String, _ characters: String, _ points: Int, _ profile:String, _ list: inout [Player]) -> [Player] {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let entityPlayer = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!
        
        let newPlayer = Player(entity: entityPlayer, insertInto: managedContext)
        
        newPlayer.name = name
        
        newPlayer.country = country
        
        newPlayer.characters = characters
        
        newPlayer.points = Int16(points)
        
        newPlayer.profile = profile
        
        do {
            try managedContext.save()
            
            list.append(newPlayer)
            
        } catch let error as NSError {
            
            print("Error save == \(error), \(error.userInfo)")
            
        }
        
        //print("List of Players \(list)")
        
        return list
        
    }
    
    
  
    
    /// UpdateEntity
    
     func updateEntity(player playerName: String, updateName name: String , updateCountry country: String , updateCharacters characters: String, updatePoints points: String, updateProfile profile: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        let attributeValue = playerName
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(Player.name) ,attributeValue )
        
        do{
            
            let results = try managedContext.fetch(fetchRequest)
            
            if let player = results.first {
                
                if !name.isEmpty {player.name = name}
                
                if !country.isEmpty {player.country = country}
                
                if !characters.isEmpty {player.characters = characters}
                
                if !points.isEmpty {player.points = Int16(points)!}
                
                if !profile.isEmpty {player.profile = profile}
                
            }
            
            try managedContext.save()
            
            
        } catch let error as NSError{
            
            print("Error update == \(error), \(error.localizedDescription)")
            
            
        }
        
    }
    
    /// DeleteEntity
    
    func deleteEntity(player playerName: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            
            return
            
        }
        
        let managerContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        let attributeValue = playerName
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(Player.name) ,attributeValue )
        
        do {
            
            let results = try managerContext.fetch(fetchRequest)
            
            if let player = results.first {
                
                managerContext.delete(player)
                
            }
            
            
        } catch let error as NSError{
            
            print("Error deleted ==\(error), \(error.userInfo)")
            
        }
        
        if managerContext.hasChanges{
            
            
            do{
                
                try managerContext.save()
                
                
            } catch let error as NSError {
                
                
                print("Error save ==\(error), \(error.userInfo)")
                
            }
            
            
        }
        
   }
    
    
    //Reload Data
    
    
    func reloadData(players list: inout [Player]) -> [Player] {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        do{
            
            if let results = try managedContext?.fetch(fetchRequest) as? [Player] {
                
                list = results
                
            }
            
        }catch let error as NSError {
            
            print("Error reload == \(error), \(error.userInfo)")
            
            
        }
        
        
        return list
        
    }
    
    
    // search Entity
    
    
    func searchData(player name: String, player list: inout [Player]) -> [Player]{
        
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managerContext = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        let attributeValue = name
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(Player.name), attributeValue)
        
        do{
            
            if let results = try managerContext?.fetch(fetchRequest) as? [Player] {
                
                
                list = results
                
            }
            
            
        }catch let error as NSError {
            
            print("Error search == \(error), \(error.userInfo)")
            
        }
        
        return list
        
        
    }
    
    // check duplicated object
    
    func duplicatedEntity(player name: String) -> Bool {
        
        var list = [Player]()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        let managedContext = appDelegate?.persistentContainer.viewContext
        
        let attributeValue = name
        
        fetchRequest.predicate = NSPredicate(format: "%K = %@", #keyPath(Player.name), attributeValue)
        
        do{
            
            if let result = try managedContext?.fetch(fetchRequest) as? [Player] {
                
                list = result
                
            }
            
        } catch let error as NSError {
            
            
            print( "Error = \(error), \(error.userInfo)" )
            
        }
        
        if list.isEmpty { return false }
        
        return true
        
    }
    
    
    

}
