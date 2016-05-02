//
//  SearchViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import LocationPicker

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var historyLocationList: [LocationItem] {
        get {
            if let locationDataList = NSUserDefaults.standardUserDefaults().arrayForKey("HistoryLocationList") as? [NSData] {
                // Decode NSData into LocationItem object.
                return locationDataList.map({ NSKeyedUnarchiver.unarchiveObjectWithData($0) as! LocationItem })
            } else {
                return []
            }
        }
        set {
            // Encode LocationItem object.
            let locationDataList = newValue.map({ NSKeyedArchiver.archivedDataWithRootObject($0) })
            NSUserDefaults.standardUserDefaults().setObject(locationDataList, forKey: "HistoryLocationList")
        }
    }
    
    @IBAction func toggleSideMenuButtonClicked(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func locationButtonClicked(sender: AnyObject) {
        let locationPicker = LocationPicker()
        locationPicker.addButtons()
        locationPicker.alternativeLocations = historyLocationList.reverse()
        locationPicker.alternativeLocationEditable = true
        
        // Completion closures
        locationPicker.selectCompletion = { selectedLocationItem in
            print("Select completion closure: " + selectedLocationItem.name)
        }
        locationPicker.pickCompletion = { pickedLocationItem in
            self.showLocation(pickedLocationItem)
            self.storeLocation(pickedLocationItem)
        }
        locationPicker.deleteCompletion = { locationItem in
            self.historyLocationList.removeAtIndex(self.historyLocationList.indexOf(locationItem)!)
        }
        
        let navigationController = UINavigationController(rootViewController: locationPicker)
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    
    func showLocation(locationItem: LocationItem) {
        //locationNameTextField.text = locationItem.name
        //locationAddressTextField.text = locationItem.formattedAddressString
    }
    
    func storeLocation(locationItem: LocationItem) {
        if let index = historyLocationList.indexOf(locationItem) {
            historyLocationList.removeAtIndex(index)
        }
        historyLocationList.append(locationItem)
    }

}