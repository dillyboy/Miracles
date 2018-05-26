//
//  UITabBarViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/20/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase

class UITabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let logoutBtn = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutPressed))
        navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.rightBarButtonItem = logoutBtn
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logoutPressed() {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: {});
            self.navigationController?.popViewController(animated: true);
        } catch let err {
            print(err)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
