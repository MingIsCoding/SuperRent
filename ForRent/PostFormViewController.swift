//
//  PostFormViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/26/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import Parse
import Notie


class PostFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // setting navigationBar to be opaque, so progress bar will not be hidden
        self.navigationController?.navigationBar.translucent = false
        
        // add a 'Submit' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: #selector(PostFormViewController.submit(_:)))
    
    
        loadForms()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func submit(_: UIBarButtonItem!) {
        
        var userEmail: String!
        
        if let value = Util.checkUserEmail() {
            userEmail = value
        } else {
            let notie = Notie(view: self.view, message: "Please sign in before posting.", style: .Confirm)
            notie.leftButtonAction = {
                Util.askForLoggingIn()
                notie.dismiss()
            }
            
            notie.rightButtonAction = {
                notie.dismiss()
            }
            notie.show()
            return
        }
        
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        let values = form.values()
        print(values)
        let rentalObject = PFObject(className: "Rental")
        
        var phone: String! {
            if let value = values["phone"] {
                return value as! String!
            } else {
                return "Not Available"
            }
        }
        
        var email: String! {
            if let value = values["email"] {
                return value as! String!
            } else {
                return "Not Available"
            }
        }
        
        var date: NSDate! {
            if let value = values["date"] {
                return value as! NSDate!
            } else {
                return NSDate()
            }
        }
        
        var type: String! {
            if let value = values["type"] {
                return value as! String!
            } else {
                return "House"
            }
        }
        
        var bedroomCnt: String! {
            if let value = values["bedroom"] {
                return value! as! String
            } else {
                return "one"
            }
        }
        
        var bathCnt: String! {
            if let value = values["bathroom"] {
                return value as! String
            } else {
                return "one"
            }
        }
        
        var rent: Double! {
            if let value = values["rent"] {
                return value as! Double
            } else {
                return 0.0
            }
        }
        
        var description: String! {
            if let value = values["description"] {
                return value as! String
            } else {
                return "Not Available"
            }
        }
        
        
        
        var address: Eureka.PostalAddress! = values["address"]! as! PostalAddress
        
        var street: String! {
            if let value = address.street {
                return value
            } else {
                return "Not Available"
            }
        }
        
        var city: String! {
            if let value = address.city {
                return value
            } else {
                return "Not Available"
            }
        }
        
        var state: String! {
            if let value = address.state {
                return value
            } else {
                return "Not Available"
            }
        }
        
        var zip: String! {
            if let value = address.postalCode {
                return value
            } else {
                return "Not Available"
            }
        }
        
        var country: String! {
            if let value = address.country {
                return value
            } else {
                return "Not Available"
            }
        }
        
        let image = values["image"]
        
        switch image {
        case let i as UIImage:
            let imageData = UIImagePNGRepresentation(i)
            let imageFile = PFFile(name: "image.png", data: imageData!)
            rentalObject["imageName"] = "Rental Image"
            rentalObject["imageFile"] = imageFile
        default:
            print("No image selected.")
        }
        
        
        rentalObject["phone"] = phone
        rentalObject["email"] = email
        rentalObject["date"] = date
        rentalObject["type"] = type
        rentalObject["bedroomCnt"] = bedroomCnt
        rentalObject["bathCnt"] = bathCnt
        rentalObject["rent"] = rent
        rentalObject["description"] = description
        rentalObject["street"] = street
        rentalObject["city"] = city
        rentalObject["state"] = state
        rentalObject["zip"] = zip
        rentalObject["country"] = country
        rentalObject["loginEmail"] = userEmail
        rentalObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved!")
            } else {
                print("error!")
            }
            progressBar.stopAnimation()
            
            let notie = Notie(view: self.view, message: "Posted successfully!", style: .Confirm)
            notie.leftButtonAction = {
                // Add your left button action here
                notie.dismiss()
            }
            
            notie.rightButtonAction = {
                // Add your right button action here
                notie.dismiss()
            }
            notie.show()
            
        }
        
    }
    
    private func loadForms() {
        form +++= Section() {
                $0.header = HeaderFooterView<SuperRentLogoView>(HeaderFooterProvider.Class)
            }
            <<< PhoneRow("phone") {
                $0.title = "Phone"
                $0.placeholder = "555-555-5555"
                $0.value = ""
            }
            <<< EmailRow("email") {
                $0.title = "Email"
                $0.placeholder = "abc@example.com"
                $0.value = ""
            }
        
        form +++= Section(footer: "by Team 9 with ❤️")
            <<< DateRow("date") {
                $0.value = NSDate()
                $0.title = "Available Date"
            }
            <<< ActionSheetRow<String>("type") {
                $0.title = "Property Type"
                $0.selectorTitle = "Type of your property?"
                $0.options = ["House", "Townhouse", "Condo", "Apartment"]
                $0.value = "House"
            }
            <<< SegmentedRow<String>("bedroom"){
                $0.title = "Bedroom"
                $0.options = ["one", "two", "three", "four"]
                $0.value = "one"
            }
            <<< SegmentedRow<String>("bathroom"){
                $0.title = "Bathroom"
                $0.options = ["one", "two", "three", "four"]
                $0.value = "one"
            }
            <<< DecimalRow("rent"){
                $0.useFormatterDuringInput = true
                $0.title = "Monthly Rent"
                $0.value = 0
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
            }
            <<< ImageRow("image"){
                $0.title = "Image"
            }
            <<< TextRow("description") {
                $0.title = "Description"
                $0.placeholder = "optional info to share"
                $0.value = ""
            }
            <<< PostalAddressRow("address"){
                $0.title = "Address"
                $0.streetPlaceholder = "Street"
                $0.statePlaceholder = "State"
                $0.postalCodePlaceholder = "Zip"
                $0.cityPlaceholder = "City"
                $0.countryPlaceholder = "Country"
                
                $0.value = PostalAddress(
                    street: "",
                    state: "",
                    postalCode: "",
                    city: "",
                    country: "US"
                )
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleLeftMenuButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
}