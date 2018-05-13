//
//  categoryViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/13/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let mainMenu = ["necklaces", "rings", "earrings", "bracelets", "anklets"]
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        super.viewDidLoad()
        print("category view")
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenu.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.imageCell.image = UIImage(named: mainMenu[indexPath.row])
        cell.labelCell.text = mainMenu[indexPath.row].capitalized
        
        return cell
    }
}
