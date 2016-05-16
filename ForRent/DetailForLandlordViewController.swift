//
//  DetailForLandlordViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/9/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit
import Notie

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
    
    @IBOutlet var pageViewLabel: UILabel!
    
    var textChanged = false
    
    var objectRef: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add a 'Edit' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(DetailForLandlordViewController.editButtonClicked))
        
        // all fields are disabled at first
        toggleFieldsState()
        
        typeField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        bedField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        bathField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        address1Field.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        address2Field.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        noteField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        availableDateField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        sfField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        rentField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        emailField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
        phoneField.addTarget(self, action: #selector(DetailForLandlordViewController.textFieldDidChange), forControlEvents: .EditingChanged)
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
    }
    
    func editButtonClicked() {
        toggleFieldsState()
        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
            self.navigationItem.rightBarButtonItem?.title = "Update"
        }
        else {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            if !textChanged {
                let notie = Notie(view: self.view, message: "No change is made.", style: .Confirm)
                notie.leftButtonAction = {
                    notie.dismiss()
                }
                notie.rightButtonAction = {
                    notie.dismiss()
                }
                notie.show()
            }
            else {
                updateFieldsContentOnServer()
            }
        }
    }
    
    func toggleFieldsState() {
        if typeField.enabled {
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
        else {
            typeField.enabled = true
            bedField.enabled = true
            bathField.enabled = true
            address1Field.enabled = true
            address2Field.enabled = true
            noteField.enabled = true
            availableDateField.enabled = true
            sfField.enabled = true
            rentField.enabled = true
            emailField.enabled = true
            phoneField.enabled = true
        }
    }
    
    func textFieldDidChange() {
        textChanged = true
    }
    
    func updateFieldsContentOnServer() {
        
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        // changes for address, square foot and available date are not currently saved
        objectRef["type"] = typeField.text ?? ""
        objectRef["bedroomCnt"] = Util.numToStr(bedField.text ?? "1")
        objectRef["bathCnt"] = Util.numToStr(bathField.text ?? "1")
        objectRef["description1"] = noteField.text ?? ""
        objectRef["phone"] = phoneField.text ?? ""
        objectRef["email"] = emailField.text ?? ""
        //objectRef["rent"] = Double(rentField.text ?? "0")
        // rent field was prefixed with "$" so the above line would always produce nil!!
        if let value = rentField.text {
            let rentStr = value.substringWithRange(Range<String.Index>(value.startIndex.advancedBy(1)..<value.endIndex))
            let rent = Double(rentStr)
            objectRef["rent"] = rent ?? 0.0
        }
        
        objectRef.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            var msg: String
            if (success) {
                msg = "Rental information updated successfully!"
            } else {
                msg = "Oops! Something's wrong. Please try again."
            }
            progressBar.stopAnimation()
            
            let notie = Notie(view: self.view, message: msg, style: .Confirm)
            notie.leftButtonAction = {
                notie.dismiss()
            }
            notie.rightButtonAction = {
                notie.dismiss()
            }
            notie.show()
        }
    }
}