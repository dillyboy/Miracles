//
//  CoreTableViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 6/1/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Toast_Swift

class CoreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var messageList = [String]()
    var message: [User]? = nil
    
    @IBOutlet weak var newMessage: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        message = CoreDataHandler.fetchObejct()
        for i in message! {
           messageList.append(i.message!)
        }
        messageTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "coreCell")
        cell.textLabel?.text = messageList[indexPath.row]
        
        return cell
    }

    
    @IBAction func addMessagePressed(_ sender: Any) {
        guard let _ = newMessage.text, newMessage.text?.count != 0 else {
            showToast()
            return
        }
        
        messageList.append(newMessage.text!)
        CoreDataHandler.saveObject(message: newMessage.text!)
        newMessage.text = ""
        self.view.makeToast("Message Added")
        messageTableView.reloadData()
    }
    
    func showToast()  {
        self.view.makeToast("Plese enter a message")
    }

}
