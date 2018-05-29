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
import ChameleonFramework

class ProductDetailViewController: UIView, UITextFieldDelegate {

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
    @IBOutlet weak var requiredLabel: UILabel!
    
    
    // Input Fields
    @IBOutlet weak var productTypeField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productDiscountField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextView!
    @IBOutlet weak var productAvailabilityField: UISwitch!
    
    var editState: Bool = false
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        productHeader.isHidden = true
        productEditView.isHidden = true
        emptyLabel.isHidden = false
        requiredLabel.isHidden = true
        saveButton.isEnabled = false
        
        // restrict to number
        self.productPriceField.delegate = self
        self.productDiscountField.delegate = self
        
        // style the product Description field
        productDescriptionField.layer.borderColor = UIColor.lightGray.cgColor
        productDescriptionField.layer.borderWidth = 1.0
        productDescriptionField.layer.cornerRadius = 6

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let typedCharacterSet = CharacterSet( charactersIn: string)
        return allowedCharacters.isSuperset(of: typedCharacterSet)
        
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
            requiredLabel.isHidden = true
        }
        
        toggleEditState(enabled: editState)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        guard let _ = productNameField.text, productNameField.text?.count != 0 else {
            showErrorToast(text: "* Product name is required")
            return
        }
        guard let _ = productPriceField.text, productPriceField.text?.count != 0 else {
            showErrorToast(text: "* Product price is required")
            return
        }
        guard let _ = productDescriptionField.text, productDescriptionField.text?.count != 0 else {
            showErrorToast(text: "* Product description is required")
            return
        }
        
        requiredLabel.isHidden = true
        
        SVProgressHUD.show()
        let newProductDictionary = ["name": productNameField.text!,
                                    "displayPicture": selectedProduct.displayPicture,
                                    "smallDescription": productDescriptionField.text!,
                                    "price": Int(productPriceField.text!)!,
                                    "availability": productAvailabilityField.isOn,
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
    
    func showErrorToast(text: String) {
        requiredLabel.text = text
        requiredLabel.isHidden = false
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
        productDiscountField.text = ""
        productDescriptionField.text = selectedProduct.description
        productAvailabilityField.isOn = selectedProduct.availability
    }
    
    func updateSelectedValues() {
        productName.text = productNameField.text!
        selectedProduct.name = productNameField.text!
        selectedProduct.price =  Int(productPriceField.text!)!
        selectedProduct.description = productDescriptionField.text!
        selectedProduct.availability = productAvailabilityField.isOn
    }
    
    func toggleEditState(enabled enable: Bool) {
        productTypeField.isEnabled = false
        productNameField.isEnabled = enable
        productPriceField.isEnabled = enable
        productDiscountField.isEnabled = enable
        productDescriptionField.isEditable = enable
        productAvailabilityField.isEnabled = enable
        
        if enable == true {
            productDescriptionField.backgroundColor = UIColor.white
        } else {
            productDescriptionField.backgroundColor = UIColor.flatWhite()
        }
    }

}
