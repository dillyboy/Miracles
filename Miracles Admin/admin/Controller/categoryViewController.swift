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
    
    let allCategories = ["Jewellery", "Handmade Cards", "Accessories"]
    
    let jewellery = ["necklaces", "rings", "earrings", "bracelets", "anklets"]
    let handmadeCards = ["seasonal", "birthday", "significant Other", "anniversary", "get Well", "funny", "friendship", "custom Made"]
    let accessories = ["novelty", "for Him", "for Her"]
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productsController: ProductsViewController = segue.destination as! ProductsViewController
        productsController.myString = selectedCategory
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return jewellery.count
        case 1:
            return handmadeCards.count
        case 2:
            return accessories.count
        default:
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CustomCollectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        let section = indexPath.section
        switch (section) {
        case 0:
            cell.imageCell.image = UIImage(named: jewellery[indexPath.row])
            cell.labelCell.text = jewellery[indexPath.row].capitalized
        case 1:
            cell.imageCell.image = UIImage(named: handmadeCards[indexPath.row])
            cell.labelCell.text = handmadeCards[indexPath.row].capitalized
        case 2:
            cell.imageCell.image = UIImage(named: accessories[indexPath.row])
            cell.labelCell.text = accessories[indexPath.row].capitalized
        default:
            cell.imageCell.image = UIImage(named: jewellery[indexPath.row])
            cell.labelCell.text = jewellery[indexPath.row].capitalized
        }
        return cell
    }
    
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            switch (index.section) {
            case 0:
                 self.selectedCategory = self.jewellery[index.row];
            case 1:
                self.selectedCategory = self.handmadeCards[index.row];
            case 2:
                self.selectedCategory = self.accessories[index.row];
            default:
                 self.selectedCategory = self.handmadeCards[index.row];
            }
            self.performSegue(withIdentifier:  "goToProducts", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as? SectionHeaderView{
            sectionHeader.sectionHeaderlabel.text = allCategories[indexPath.section]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
}
