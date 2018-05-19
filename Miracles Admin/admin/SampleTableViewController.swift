//
//  SampleTableViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/18/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase

class SampleTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    let jewellery = ["necklaces", "rings", "earrings", "bracelets", "anklets"]
    var productsArray : [Product] = [Product]()
    
    @IBOutlet var productsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTable.delegate = self
        productsTable.dataSource = self

        ref =  Database.database().reference()
        
        databaseHandle = ref.child("products/Necklaces").observe(DataEventType.value) { (snapshot) in
            if let allProducts = snapshot.value as? [String:AnyObject] {
                for (_,product) in allProducts {
                    let productName = product["name"]!! as! String
                    let productImage = product["displayPicture"]!! as! String
                    let productDescription = product["smallDescription"]!! as! String
                    
                    let product  = Product()
                    product.displayPicture = productImage
                    product.name = productName
                    product.description = productDescription
                    
                    self.productsArray.append(product)
                }
               self.productsTable.reloadData()
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func didClickOnExitButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableCell", for: indexPath) as! ProductTableViewCell

        cell.productName.text = productsArray[indexPath.row].name
        cell.productDescription.text = productsArray[indexPath.row].description
        cell.productImage.contentMode = .scaleAspectFill
        
        cell.productImage.downloadedFrom(link: productsArray[indexPath.row].displayPicture)
        // cell.productImage.image = UIImage(named: productsArray[indexPath.row].displayPicture)
        
       // cell.productImage.image = UIImage(named: jewellery[indexPath.row])
     //   cell.productName.text = jewellery[indexPath.row].capitalized
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
