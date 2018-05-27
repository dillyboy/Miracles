//
//  alertExtension.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/27/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindowLevelAlert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
