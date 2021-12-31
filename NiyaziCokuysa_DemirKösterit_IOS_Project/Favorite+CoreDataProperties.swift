//
//  Favorite+CoreDataProperties.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var price: Double
    @NSManaged public var desc: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var category: String?

}
