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

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(_ sender: Any) {
//      Auth.auth().createUser
        SVProgressHUD.show()
        // emailTextField.text!
        // passwordTextField.text!
        Auth.auth().signIn(withEmail: "dilshan.liyanage@hotmail.co.uk", password: "12345678") { (user, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                print(error!)
                createAlert(title: "Login Failed", message: "Email or password is invalid!")
            } else {
                print("login successful")
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
    
}

