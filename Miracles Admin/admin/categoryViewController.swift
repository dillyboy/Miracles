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
    var selectedCategory = String()
    
    let jewellery = ["necklaces", "rings", "earrings", "bracelets", "anklets"]
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        super.viewDidLoad()
        print("category view")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsController: ProductsViewController = segue.destination as! ProductsViewController
        productsController.myString = selectedCategory
    }
    

    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jewellery.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CustomCollectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        cell.imageCell.image = UIImage(named: jewellery[indexPath.row])
        cell.labelCell.text = jewellery[indexPath.row].capitalized
        
        return cell
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            self.selectedCategory = self.jewellery[index.row];
            self.performSegue(withIdentifier:  "goToProducts", sender: self)
        }
    }
}
