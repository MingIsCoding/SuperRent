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


class PostFormViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        form +++= Section("Contact")
            <<< PhoneRow() {
                $0.title = "Phone"
            }
            <<< EmailRow() {
                $0.title = "Email"
        }
        
        form +++= Section("Rental Info")
            <<< DateRow() {
                $0.value = NSDate()
                $0.title = "Available Date"
            }
            <<< ActionSheetRow<String>() {
                $0.title = "Property Type"
                $0.selectorTitle = "Type of your property?"
                $0.options = ["House", "Townhouse", "Condo", "Apartment"]
                $0.value = "House"
            }
            <<< SegmentedRow<String>(){
                $0.title = "Bedroom"
                $0.options = ["one", "two", "three", "four"]
                $0.value = "one"
            }
            <<< SegmentedRow<String>(){
                $0.title = "Bathroom"
                $0.options = ["one", "two", "three", "four"]
                $0.value = "one"
            }
            <<< DecimalRow(){
                $0.useFormatterDuringInput = true
                $0.title = "Currency style"
                $0.value = 0
                let formatter = CurrencyFormatter()
                formatter.locale = .currentLocale()
                formatter.numberStyle = .CurrencyStyle
                $0.formatter = formatter
            }
            <<< ImageRow(){
                $0.title = "Image"
            }
            <<< TextRow() {
                $0.title = "Description"
                $0.placeholder = "optional"
            }
        
            <<< PostalAddressRow(){
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
}