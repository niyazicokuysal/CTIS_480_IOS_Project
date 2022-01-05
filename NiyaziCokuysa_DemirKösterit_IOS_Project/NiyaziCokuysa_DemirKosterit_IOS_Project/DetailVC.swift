//
//  DetailVC.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView
import AVFoundation

class DetailVC: UIViewController {
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mtextArea: UITextView!
    
    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var mFavorite: UIBarButtonItem!
    
    var audioPlayer: AVAudioPlayer?
    
    var name: String?
    var image: String?
    var desc: String?
    var price: Double?
    var favorite: Favorite?
    
    @IBAction func onDoubleTapImage(_ sender: Any) {
        if(mFavorite.image == UIImage(systemName: "star")){
            addFavorite()
            SCLAlertView().showInfo("Added to Favorites", subTitle: "Added " + name! + " to favorites")
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            delete()
            SCLAlertView().showInfo("Removed from Favorites", subTitle: "Removed " + name! + " from favorites")
            mFavorite.image = UIImage(systemName: "star")
        }
    }
    @IBAction func onStarPressed(_ sender: Any) {
        
        let pathToSound = Bundle.main.path(forResource: "notification", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch  {
            print(error)
        }
        
        if(mFavorite.image == UIImage(systemName: "star")){
            addFavorite()
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            delete()
            mFavorite.image = UIImage(systemName: "star")
        }
    }
    
    func addFavorite() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newFavoriteItem = Favorite.createInManagedObjectContext(context, name: name!, desc: desc!, image: image!, price:NSNumber(value: price!))
        self.fetchData()
        save()
    }
    
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func delete(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favoriteToDelete = favorite
        context.delete(favoriteToDelete!)
        save()
    }
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        let search = image
        let mPredicate = NSPredicate(format: "image contains[c] %@", search!)
        
        fetchRequest.predicate = mPredicate
        
        do {
            let result = try context.fetch(fetchRequest)
            if(result.count > 0){
                favorite = result[0] as? Favorite
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchData()
        if(favorite?.desc != nil){
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            mFavorite.image = UIImage(systemName: "star")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mImageView.image = UIImage(named: image!)
        mName.text = name!
        mPrice.text?.append("\(price!)₺")
        mtextArea.text = desc!
        
        fetchData()
        if(favorite != nil){
            mFavorite.image = UIImage(systemName: "star.fill")
        }else{
            mFavorite.image = UIImage(systemName: "star")
        }
        
        
    }
}
