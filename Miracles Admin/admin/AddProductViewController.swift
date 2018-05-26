//
//  AddProductViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/20/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase

class AddProductViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    // Input Fields
    @IBOutlet weak var productTypeField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productDiscountField: UITextField!
    @IBOutlet weak var productSmallDescriptionField: UITextField!
    @IBOutlet weak var productLargeDescriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        productTypeField.isEnabled = false
        productTypeField.text = currentCategory
    }
    
    @IBAction func savePressed(_ sender: Any) {
        print(productTypeField.text!);
        
        let myDatabase =  Database.database().reference().child("products").child(currentCategory)
        let newProductDictionary = ["name": productNameField.text!,
                                    "displayPicture": "https://firebasestorage.googleapis.com/v0/b/project-5075190380563343601.appspot.com/o/products%2FAnklets%20%26%20Toe%20Rings%2FTree%20of%20Life%2Fhollow-tree-display.jpg?alt=media&token=ec4f7ee7-6cc3-4a4a-9a63-6b152cccd519",
                                    "smallDescription": productSmallDescriptionField.text!,
                                    "price": Int(productPriceField.text!)!,
                                    "availability": true,
                                    "type": currentCategory] as Any
        
//        let productName = product["name"]!! as! String
//        let productImage = product["displayPicture"]!! as! String
//        let productDescription = product["smallDescription"]!! as! String
//        let productPrice = product["price"]!! as! Int
        myDatabase.childByAutoId().setValue(newProductDictionary) { (error, ref) in
            if error != nil {
                print(error!)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    

    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
