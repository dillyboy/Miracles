//
//  CoreDataHandler.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/29/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveObject(message: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(message, forKey: "message")
        
        do {
            print("data saved")
            try context.save()
            return true
        } catch {
            print("data not saved")
            return false
        }
    }
    
    class func fetchObejct() ->[User] {
        let context = getContext()
        var user:[User]? = nil
        do {
            user = try context.fetch(User.fetchRequest())
            return user!
        } catch {
            return user!
        }
    }
}
