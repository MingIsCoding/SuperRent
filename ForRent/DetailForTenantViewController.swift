//
//  DetailForTenantViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/11/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit

class DetailForTenantViewController: UIViewController {
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
    
    @IBOutlet var pageViewLabel: UILabel!

    @IBOutlet var favButton: DOFavoriteButton!
    @IBAction func favButtonClicked(sender: DOFavoriteButton) {
        if sender.selected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // to hide the tab bar
        self.tabBarController?.tabBar.hidden = true
        
        imageView.image = cell.rentalImageView.image
        typeField.text = cell.type
        bedField.text = "\(cell.bedCnt)"
        bathField.text = "\(cell.bathCnt)"
        address1Field.text = cell.address1Label.text
        address2Field.text = cell.address2Label.text
        noteField.text = cell.des
        availableDateField.text = cell.dateLabel.text
        sfField.text = "\(cell.footage) ft²"
        rentField.text = cell.rentLabel.text
        emailField.text = cell.email
        phoneField.text = cell.phoneLabel.text
        pageViewLabel.text = "\(cell.pageView) views"
        
        disableFieldsEdit()
    }
    
    func disableFieldsEdit() {
        typeField.enabled = false
        bedField.enabled = false
        bathField.enabled = false
        address1Field.enabled = false
        address2Field.enabled = false
        noteField.enabled = false
        availableDateField.enabled = false
        sfField.enabled = false
        rentField.enabled = false
        emailField.enabled = false
        phoneField.enabled = false
    }
}