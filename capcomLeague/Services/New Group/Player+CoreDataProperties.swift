//
//  Player+CoreDataProperties.swift
//  capcomLeagueCd
//
//  Created by Eduardo Delgado Guerrero on 1/12/22.
//  Copyright © 2022 Eduardo Delgado Guerrero. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var characters: String?
    @NSManaged public var points: Int16
    @NSManaged public var profile: String?

}
