//
//  ProductDetailViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/20/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ProductDetailViewController: UIView {

    @IBOutlet weak var productHeader: UIView!
    @IBOutlet weak var productEditView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    // UI Buttons
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    // UI Label
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    // Input Fields
    @IBOutlet weak var productTypeField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productDiscountField: UITextField!
    @IBOutlet weak var productSmallDescriptionField: UITextField!
    @IBOutlet weak var productLargeDescriptionField: UITextField!
    
    var editState: Bool = false
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        productHeader.isHidden = true
        productEditView.isHidden = true
        emptyLabel.isHidden = false
        saveButton.isEnabled = false
        toggleEditState(enabled: editState)
        if selectedProduct.name != "" {
            emptyLabel.isHidden = true
            fillForm()
            productName.text = selectedProduct.name
            
            productImage.contentMode = .scaleAspectFill
            productImage.downloadedFrom(link: selectedProduct.displayPicture)
            
            productHeader.isHidden = false
            productEditView.isHidden = false
        
        }
    }
    
    
    @IBAction func editPressed(_ sender: Any) {
        editState = !editState
        
        if editState == true {
            saveButton.isEnabled = true
            editButton.setTitle("Cancel", for: .normal)
        } else {
            fillForm()
            saveButton.isEnabled = false
            editButton.setTitle("Edit", for: .normal)
        }
        
        toggleEditState(enabled: editState)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        SVProgressHUD.show()
        let newProductDictionary = ["name": productNameField.text!,
                                    "displayPicture": selectedProduct.displayPicture,
                                    "smallDescription": productSmallDescriptionField.text!,
                                    "price": Int(productPriceField.text!)!,
                                    "availability": true,
                                    "type": currentCategory] as Any
        
        let myDatabase =  Database.database().reference().child("products").child(currentCategory)
        myDatabase.updateChildValues([selectedProduct.key: newProductDictionary]) { (error, ref) in
             SVProgressHUD.dismiss()
            if error != nil {
                print(error!)
            } else {
                self.saveButton.isEnabled = false
                self.editButton.setTitle("Edit", for: .normal)
                self.toggleEditState(enabled: false)
                self.updateSelectedValues()
            }
        }
    }
    
    
    @IBAction func deletePressed(_ sender: Any) {

        let alert = UIAlertController(title: "Delete Product", message: "Are you sure you want to delete this product?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            let myDatabase =  Database.database().reference().child("products").child(currentCategory).child(selectedProduct.key)
            myDatabase.removeValue { (error, ref) in
                if error != nil {
                    print(error!)
                } else {
                    self.resetForm()
                }
            }
        }))
        alert.show()

    }
    
    func resetForm() {
        selectedProduct = Product()
        if selectedProduct.name == "" {
            emptyLabel.isHidden = false
            
            productHeader.isHidden = true
            productEditView.isHidden = true
            
        }
    }
    
    func fillForm() {
        productTypeField.text = currentCategory
        productNameField.text = selectedProduct.name
        productPriceField.text = String(selectedProduct.price)
        productSmallDescriptionField.text = selectedProduct.description
    }
    
    func updateSelectedValues() {
        productName.text = productNameField.text!
        selectedProduct.name = productNameField.text!
        selectedProduct.price =  Int(productPriceField.text!)!
        selectedProduct.description = productSmallDescriptionField.text!
    }
    
    func toggleEditState(enabled enable: Bool) {
        productTypeField.isEnabled = false
        productNameField.isEnabled = enable
        productPriceField.isEnabled = enable
        productDiscountField.isEnabled = enable
        productSmallDescriptionField.isEnabled = enable
        productLargeDescriptionField.isEnabled = enable
    }

}
