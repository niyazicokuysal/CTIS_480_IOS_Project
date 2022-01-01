//
//  MenuVC.swift
//  NiyaziCokuysa_DemirKosterit_IOS_Project
//
//  Created by CTIS Student on 31.12.2021.
//  Copyright © 2021 niyazi-demir. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let mDataSource = DataSource()
    
    @IBOutlet var mCollectionView: UICollectionView!
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mDataSource.numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mDataSource.numbeOfItemsInEachCategory(index: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let meals: [Meal] = mDataSource.itemsInCategory(index: indexPath.section)
        let meal = meals[indexPath.row]
        
        cell.cellLabel.text = meal.name
        cell.cellImage.image = UIImage(named: meal.image)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionReusableView
        
        let label = mDataSource.getCategoryLabelAtIndex(index: indexPath.section)
        headerView.headerLabel.text = label
        return headerView
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let indexPath = getIndexPathForSelectedCell() {
                //print(indexPath)
                let meal = mDataSource.itemsInCategory(index: indexPath.section)[indexPath.row]
                
                //print(record.category,record.image,record.name)
                
                let vc = segue.destination as! DetailVC
                vc.name = meal.name
                vc.desc = meal.description
                vc.image = meal.image
                vc.price = meal.price
            }
        }
    }
    
    // Our function to find the indexPath of selected cell
    func getIndexPathForSelectedCell() -> IndexPath? {
        var indexPath: IndexPath?
        
        // Since multiple cells can be selected, we need to check the count
        if mCollectionView.indexPathsForSelectedItems!.count > 0 {
            indexPath = mCollectionView.indexPathsForSelectedItems![0] as IndexPath
        }
        //print(indexPath!)
        return indexPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDataSource.populate()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
