//
//  AddProductViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/20/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase

class AddProductViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var popupView: UIView!
    
    // Label
    @IBOutlet weak var requiredLabel: UILabel!
    
    
    // Input Fields
    @IBOutlet weak var productTypeField: UITextField!
    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productDiscountField: UITextField!
    @IBOutlet weak var productDescriptionField: UITextView!
    @IBOutlet weak var productAvailabilityField: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        requiredLabel.isHidden = true
        
        productTypeField.isEnabled = false
        productTypeField.text = currentCategory
        
        // restrict to number
        self.productPriceField.delegate = self
        self.productDiscountField.delegate = self
        
        // style the product Description field
        productDescriptionField.layer.borderColor = UIColor.lightGray.cgColor
        productDescriptionField.layer.borderWidth = 1.0
        productDescriptionField.layer.cornerRadius = 6
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        // let allowedCorrectedSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet( charactersIn: string)
        return allowedCharacters.isSuperset(of: typedCharacterSet)
        
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
        
        let myDatabase =  Database.database().reference().child("products").child(currentCategory)
        let newProductDictionary = ["name": productNameField.text!,
                                    "displayPicture": "https://dl.dropboxusercontent.com/s/cgoeku9q7akbxb5/placeholder.png?dl=0",
                                    "smallDescription": productDescriptionField.text!,
                                    "price": Int(productPriceField.text!)!,
                                    "availability": productAvailabilityField.isOn,
                                    "type": currentCategory] as Any
        
        myDatabase.childByAutoId().setValue(newProductDictionary) { (error, ref) in
            if error != nil {
                print(error!)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showErrorToast(text: String) {
        requiredLabel.text = text
        requiredLabel.isHidden = false
    }

    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
