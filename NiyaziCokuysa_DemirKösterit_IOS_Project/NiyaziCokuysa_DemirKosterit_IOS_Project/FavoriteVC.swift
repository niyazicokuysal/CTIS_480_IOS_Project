//
//  FavoriteVC.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 2.01.2022.
//  Copyright © 2022 niyazi-demir. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView

class FavoriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mFavorite = [Favorite]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mFavorite.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            mFavorite = fetchResults as! [Favorite]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let favorite = mFavorite[indexPath.row]
        
        cell.imageView?.image = UIImage(named: favorite.image!)
        cell.textLabel?.text = favorite.name!
        cell.detailTextLabel!.text = "Price: " + String(favorite.price) + "₺"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if(editingStyle == .delete ) {
            let studentToDelete = mFavorite[indexPath.row]
            
            context.delete(studentToDelete)
            
            mFavorite.remove(at: indexPath.row)
            
            mTableView.deleteRows(at: [indexPath], with: .automatic)
            
            save()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let favorite = mFavorite[mTableView.indexPathForSelectedRow!.row]
            let vc = segue.destination as! DetailVC
            vc.name = favorite.name
            vc.desc = favorite.desc
            vc.image = favorite.image
            vc.price = favorite.price
        }
    }
    
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
            mTableView.reloadData()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        do {
            let results = try context.fetch(fetchRequest)
            mFavorite = results as! [Favorite]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        mTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.fetchData()
        // Do any additional setup after loading the view.
    }
}

