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
    @IBOutlet var typeField: UITextField!
    @IBOutlet var bedField: UITextField!
    @IBOutlet var bathField: UITextField!
    @IBOutlet var address1Field: UITextField!
    
    @IBOutlet var address2Field: UITextField!
    
    @IBOutlet var noteField: UITextField!
    @IBOutlet var availableDateField: UITextField!
    @IBOutlet var sfField: UITextField!
    @IBOutlet var rentField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var phoneField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // to hide the tab bar
        self.tabBarController?.tabBar.hidden = true
        
        imageView.image = cell.rentalImageView.image
        bedField.text = "\(cell.bedCnt)"
        
        
    }
}