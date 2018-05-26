//
//  ProductDetailViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/20/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIView {

    @IBOutlet weak var productHeader: UIView!
    @IBOutlet weak var productEditView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    // UI Buttons
    @IBOutlet weak var editButton: UIButton!
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
        toggleEditState(enabled: editState)
        if selectedProduct.name != "" {
            dump(selectedProduct)
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
            editButton.setTitle("Cancel", for: .normal)
        } else {
            editButton.setTitle("Edit", for: .normal)
        }
        
        toggleEditState(enabled: editState)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        print("delete pressed")
       // createAlert(title: "Login Failed", message: "Email or password is invalid!")
        

    }
    
//    init() {
//        super.init(frame: UIScreen.main.bounds);
//        print("My Custom Init");
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector (viewClicker(sender:)))
//        self.deleteButton.addGestureRecognizer(gesture)
//
//        return;
//
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        // fatalError("init(coder:) has not been implemented")
//        return nil
//    }
    
//    @objc func viewClicker(sender : UITapGestureRecognizer) {
//        print("hi");
//    }

    
    func fillForm() {
        productTypeField.text = currentCategory
        productNameField.text = selectedProduct.name
        productPriceField.text = String(selectedProduct.price)
        productSmallDescriptionField.text = selectedProduct.description
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
