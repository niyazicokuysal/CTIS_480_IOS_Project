//
//  DetailVC.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mtextArea: UITextView!

    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var mFavorite: UIBarButtonItem!
    
    var name: String?
    var image: String?
    var desc: String?
    var price: Double = 0.0
    var favorite: Favorite?
    
    @IBAction func onStarPressed(_ sender: Any) {
        
        if(mFavorite.image == UIImage(systemName: "star")){
            addFavorite()
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            delete()
            mFavorite.image = UIImage(systemName: "star")
        }
    }
    
    func addFavorite() {
         //print("delegate received")
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         
        let newFavoriteItem = Favorite.createInManagedObjectContext(context, name: name!, desc: desc!, image: image!, price:NSNumber(value: price))
         
         //self.fetchData()
         save()
     }
    
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
            // mTableView.reloadData()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
     
    func delete(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favoriteToDelete = favorite
        context.delete(favoriteToDelete!)
    }
    
    // Our function to fetch data from Core Data
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        let search = image
        let mPredicate = NSPredicate(format: "image contains[c] %@", search!)
        
        fetchRequest.predicate = mPredicate
        
        do {
            let result = try context.fetch(fetchRequest)
            if(result.count > 0){
                //print("result if check")
                favorite = result[0] as? Favorite
            }
            print(favorite)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mImageView.image = UIImage(named: image!)
        mName.text = name!
        mPrice.text?.append("\(price)₺")
        mtextArea.text = desc!
        
        fetchData()
        if(favorite != nil){
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            mFavorite.image = UIImage(systemName: "star")
        }
        
        
    }
}
