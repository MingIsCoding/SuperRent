//
//  SearchViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import LocationPicker
import Eureka
import Notie

class SearchViewController: FormViewController, UISearchBarDelegate {
    
    let searchBar = UISearchBar()
    var selectedLocation: [String]?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting navigationBar to be opaque
        self.navigationController?.navigationBar.translucent = false
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.autocorrectionType = .Yes
        navigationItem.titleView = searchBar
        
        loadFilterForms()
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
            print("Select completion closure: " + (selectedLocationItem.addressDictionary?.description)!)
            print(selectedLocationItem.addressDictionary?["FormattedAddressLines"] as! [String])
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
        selectedLocation = formatLocationString(locationItem)
        print(selectedLocation)
        form.setValues(["location": "\(selectedLocation![0]), \(selectedLocation![1])", "state": selectedLocation![2], "zip": selectedLocation![3], "locationFilter": "Filter location"])
        //form.rowByTag("location")?.updateCell()
        tableView?.reloadData()
    }
    
    func storeLocation(locationItem: LocationItem) {
        if let index = historyLocationList.indexOf(locationItem) {
            historyLocationList.removeAtIndex(index)
        }
        historyLocationList.append(locationItem)
    }
    
    private func loadFilterForms() {
        
        form +++ Section()
            <<< MultipleSelectorRow<String>("type") {
                $0.title = "Rental Type"
                $0.options = ["🏡 House", "🏚 Townhouse", "🏢 Apartment", "🏤 Condo"]
                $0.value = ["🏡 House"]
                }
                .onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: from, action: #selector(self.multipleSelectorDone(_:)))
            }
            
            +++ Section()
            <<< SegmentedRow<String>("locationFilter"){
                $0.options = ["Filter location", "Default"]
                $0.value = "Default"
            }
            <<< TextRow("location") {
                $0.title = "Location"
                $0.placeholder = "San Jose"
                $0.disabled = "$locationFilter = 'Default'"
            }
            
            <<< TextRow("state") {
                $0.title = "State"
                $0.placeholder = "CA"
                $0.disabled = "$locationFilter = 'Default'"
            }
            
            <<< ZipCodeRow("zip") {
                $0.title = "Zip"
                $0.placeholder = "95112"
                $0.disabled = "$locationFilter = 'Default'"
            }
            
            +++ Section()
            <<< SegmentedRow<String>("priceFilter"){
                $0.options = ["Filter price", "Any price"]
                $0.value = "Any price"
            }
            
            <<< SliderRow("maxPrice") {
                $0.title = "Max price"
                $0.value = 800
                $0.minimumValue = 600.0
                $0.maximumValue = 4000.0
                $0.steps = 17
                $0.disabled = "$priceFilter = 'Any price'"
            }
        
    }
    
    private func formatLocationString(location: LocationItem) -> [String] {
        var address: [String] = [String]()
        let dic = location.addressDictionary
        address.append(dic!["Street"] != nil ? (dic!["Street"] as! String) : (dic!["Name"] != nil ? (dic!["Name"] as! String) : ""))
        address.append(dic!["City"] != nil ? (dic!["City"] as! String) : "")
        address.append(dic!["State"] as! String)
        address.append(dic!["ZIP"] as! String)
        address.append(address[0] + "\n" + address[1] + " " + address[2] + " " + address[3])
        
        return address
    }
    
    // for MultipleSelectorRow of Eureka form
    func multipleSelectorDone(item: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // to show a `cancel` button in the search bar
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // clear existing text and dismiss keyboard when `cancel` clicked
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    // respond to search action
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // searchBar.text is an optional: Optional("")/ Optional("Pet")
        let keyword = searchBar.text
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        //let resultVC = SearchResultViewController()
        //presentViewController(resultVC, animated: true, completion: nil)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let resultVC = mainStoryboard.instantiateViewControllerWithIdentifier("searchResultVC") as! SearchResultViewController
        // set the query params
        resultVC.queryKeyword = keyword
        
        // extract the values the user has specified in the form
        let values = form.values()
        // ["state": nil, "locationFilter": Optional("Default"), "zip": nil, "priceFilter": Optional("Any price"), "maxPrice": Optional(800.0), "location": nil, "type": Optional(Set(["🏡 House"]))]
        resultVC.queryTypes = [String](Util.houseTypeConverter(values["type"] as! Set<String>))
        if (values["priceFilter"] as! String) != "Any price" {
            resultVC.queryMaxPrice = Double(values["maxPrice"] as! Float)
        }
        if (values["locationFilter"] as! String) != "Default" {
            
            // if user manually changed city and zip
            //let inputLocation = values["location"] as! String
            var inputLocation: String! {
                if let value = values["location"] {
                    if let value = value {
                        return value as! String
                    }
                }
                return ""
            }
            if inputLocation != "" {
                resultVC.queryCity = inputLocation
            }
            //let inputZip = values["zip"] as! String
            var inputZip: String! {
                if let value = values["zip"] {
                    if let value = value {
                        return value as! String
                    }
                }
                return ""
            }
            if inputZip != "" {
                resultVC.queryZip = inputZip
            }
            
            // if location picker is used, city and zip will be set using these
            if let selectedLocation = selectedLocation {
                resultVC.queryCity = selectedLocation[1]
                resultVC.queryZip = selectedLocation[3]
            }
            
            // otherwise, these two query fields will be default to `San Jose` and `95112`
            // specified in SearchResultViewController.swift
        }
        
        // present the search result VC in a navigation VC
        let navigationVC = UINavigationController(rootViewController: resultVC)
        presentViewController(navigationVC, animated: true, completion: nil)
        
    }

}