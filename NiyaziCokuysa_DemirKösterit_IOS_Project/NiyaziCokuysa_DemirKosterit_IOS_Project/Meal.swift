//
//  Meal.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//

import Foundation
class Meal {
    var name: String
    var category: String
    var description: String
    var image: String
    var price: Double
    
    init(name: String, category: String, description: String, image: String, price: Double) {
        self.category = category
        self.name = name
        self.description = description
        self.image = image
        self.price = price
    }
        
}
