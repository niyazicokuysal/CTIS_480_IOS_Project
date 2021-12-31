//
//  DataSource.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//

import Foundation

class DataSource {
var mealList: [Meal] = []
var categories: [String] = []


func numbeOfItemsInEachCategory(index: Int) -> Int {
    return itemsInCategory(index: index).count
}

func numberOfCategories() -> Int {
    return categories.count
}

func getCategoryLabelAtIndex(index: Int) -> String {
    return categories[index]
}

// MARK: - Populate Data from files
func populate() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                
                // https://www.dotnetperls.com/guard-swift
                guard let json = try? JSON(data: data as Data) else {
                    print("Error with JSON")
                    return
                }
                //print(json)
                
                for index in 0..<json["items"].count {
                    let name = json["items"][index]["name"].string!
                    let category = json["items"][index]["category"].string!
                    let description = json["items"][index]["description"].string!
                    let image = json["items"][index]["image"].string!
                    let price = json["items"][index]["price"].double!
                    
                    let meal = Meal(name: name, category: category, description: description, image: image, price: price)
                    mealList.append(meal)
                    
                    if !categories.contains(category) {
                        categories.append(category)
                    }
                }
            }
            else {
                print("Data error")
            }
        }
    //print(mealList)
    //print(categories)
}

    
    // MARK: - itemsForEachGroup
    func itemsInCategory(index: Int) -> [Meal] {
        let item = categories[index]
        
        // See playground6 for Closure
        // http://locomoviles.com/uncategorized/filtering-swift-array-dictionaries-object-property/
        
        let filteredItems = mealList.filter { (meal: Meal) -> Bool in
            return meal.category == item
        }
        return filteredItems
    }
}
