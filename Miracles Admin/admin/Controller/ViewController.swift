//
//  ViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/13/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import Toast_Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var user: [User]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Get email and password entered in the past
        if let email = UserDefaults.standard.value(forKey: "email") as? String {
            emailTextField.text = email
        }
        if let password = UserDefaults.standard.value(forKey: "password") as? String {
            passwordTextField.text = password
        }
        
        //        user = CoreDataHandler.fetchObejct()
        //        for i in user! {
        //            print(i.username!)
        //            print(i.password!)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, emailTextField.text?.count != 0, (passwordTextField.text != nil), passwordTextField.text?.count != 0 else {
            showToast()
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                print(error!)
                createAlert(title: "Login Failed", message: "Email or password is invalid!")
            } else {
                print("login successful")
                // CoreDataHandler.saveObject(username: "dilshan", password: "some")
                UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                UserDefaults.standard.set(self.passwordTextField.text!, forKey: "password")
                self.performSegue(withIdentifier:  "goToTabbledView", sender: self)
            }
        }
        
        func createAlert (title:String, message:String)
        {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            //CREATING ON BUTTON
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                print ("YES")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showToast() {
        self.view.makeToast("Plese enter your email and password")
    }
    
}

