//
//  SampleTableViewController.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/18/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

var selectedProduct: Product = Product()

class SampleTableViewController: UITableViewController,UISearchBarDelegate {
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    var productsArray : [Product] = [Product]()
    var objects = [Any]()
    let searchString = ""
    var searchActive : Bool = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var productsTable: UITableView!
    var filtered:[String] = []
    var filteredSearch:[Product] = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsTable.delegate = self
        productsTable.dataSource = self
        searchBar.delegate = self
        self.title = currentCategory
        
        ref =  Database.database().reference()
        SVProgressHUD.show()
        databaseHandle = ref.child("products/\(currentCategory)").observe(DataEventType.value) { (snapshot) in
            if let allProducts = snapshot.value as? [String:AnyObject] {
                self.productsArray = [Product]()
                SVProgressHUD.dismiss()
                for (key, product) in allProducts {
                    let productName = product["name"]!! as! String
                    let productImage = product["displayPicture"]!! as! String
                    let productDescription = product["smallDescription"]!! as! String
                    let productPrice = product["price"]!! as! Int
                    
                    let product  = Product()
                    product.displayPicture = productImage
                    product.name = productName
                    product.description = productDescription
                    product.price = productPrice
                    product.key = key
                    
                    self.productsArray.append(product)
                }
                self.productsTable.reloadData()
            }
        }
        print("list2-----",self.productsArray)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func didClickOnExitButton(_ sender: Any) {
        selectedProduct = Product()
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredSearch = self.productsArray.filter { (product: Product) -> Bool in
            let tmp: NSString = product.name as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
            //            if let nameString = product.name,
            //                let searchText = searchBar.text?.lowercased() {
            //                return nameString.lowercased().contains(searchText)
            //            } else {
            //                return false
            //            }
        }
        // print("filtered",filteredSearch)
        
        
        if(filteredSearch.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
      //  print("filtered",filteredSearch)
        self.tableView.reloadData()
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
        
        if(searchActive) {
            return filteredSearch.count
        }
        return productsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableCell", for: indexPath) as! ProductTableViewCell
        if(searchActive){
            cell.productName.text = filteredSearch[indexPath.row].name
            cell.productDescription.text = filteredSearch[indexPath.row].description
            cell.productImage.contentMode = .scaleAspectFill
            
            cell.productImage.downloadedFrom(link: filteredSearch[indexPath.row].displayPicture)
            
        }else{
            cell.productName.text = productsArray[indexPath.row].name
            cell.productDescription.text = productsArray[indexPath.row].description
            cell.productImage.contentMode = .scaleAspectFill
            
            cell.productImage.downloadedFrom(link: productsArray[indexPath.row].displayPicture)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                print("navigate");
                if searchActive {
                    selectedProduct = filteredSearch[indexPath.row]
                } else {
                    selectedProduct = productsArray[indexPath.row]
                }
                
            }
        }
        
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
