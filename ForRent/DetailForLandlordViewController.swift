//
//  DetailForLandlordViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/9/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit

class DetailForLandlordViewController: UIViewController {
    var cell: RentalCell!
    
    @IBOutlet var imageView: PFImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.image = cell.rentalImageView.image
    }
}