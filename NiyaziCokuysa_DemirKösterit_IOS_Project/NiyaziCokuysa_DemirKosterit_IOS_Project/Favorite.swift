//
//  Favorite.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//


import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {

    // Static method (class keyword)
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, category: String, desc: String, image: String ,price: NSNumber) -> Favorite {
        let favoriteObject = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context) as! Favorite
        favoriteObject.name = name
        favoriteObject.desc = desc
        favoriteObject.image = image
        favoriteObject.category = category
        favoriteObject.price = Double(truncating: price)
        
        return favoriteObject
    }
    
}
