//
//  CustomCollectionViewCell.swift
//  admin
//
//  Created by Dilshan Liyanage on 5/13/18.
//  Copyright © 2018 Dilshan Liyanage. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var labelCell: UILabel!
    
    let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 0.2)
    let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 0.1)
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageCell.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.imageCell.layer.cornerRadius = 20
        self.imageCell.layer.borderWidth = 2
        self.imageCell.layer.borderColor = UIColor.lightGray.cgColor
       // self.imageCell.layer.backgroundColor = UIColor.lightGray.cgColor
        self.imageCell.setGradientBackground(colorOne: lightGrey, colorTwo: veryDarkGrey)
    }
    
    
}
