//
//  SearchResultViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/8/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit
import Notie

class SearchResultViewController: UITableViewController {
    
    var rentalObjects: [PFObject] = []
    var queryKeyword: String?
    var queryTypes: [String]?
    var queryMaxPrice: Double?
    var queryCity = "San Jose"
    var queryZip = "95112"
    var fromNotificationWithRentalID: String?
    var saveSearch = false
    var scheduleType: Int = 0
    var nextPushTime: Double = NSDate().timeIntervalSince1970 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 86
        
        self.navigationItem.title = "Results"
        // add a 'Done' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(SearchResultViewController.dismissSelf))
        
        // progress bar animation
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        // retrieve logged in user's email
        let userEmail: String = Util.checkUserEmail() ?? "NA"
        
        // for saved search functionality
        let searchCondition = PFObject(className:"Search")
        
        // do the query
        let query = PFQuery(className: "Rental")
        
        // tell if it's from notification
        if let rentalID = fromNotificationWithRentalID {
            query.getObjectInBackgroundWithId(rentalID) {
                (rental: PFObject?, error: NSError?) -> Void in
                progressBar.stopAnimation()
                if error == nil && rental != nil {
                    print("Rental from notification found in database.")
                    self.rentalObjects.append(rental!)
                    self.tableView.reloadData()
                } else {
                    print(error)
                }
            }
        } else {
            if let keyword = queryKeyword {
                query.whereKey("description1", containsString: keyword)
                searchCondition["keyword"] = keyword
            }
            if let types = queryTypes {
                print(types)
                query.whereKey("type", containedIn: types)
                searchCondition["type"] = types
            }
            if let price = queryMaxPrice {
                print(price)
                query.whereKey("rent", lessThan: price)
                searchCondition["maxPrice"] = queryMaxPrice
            }
            query.whereKey("city", equalTo: queryCity)
            query.whereKey("zip", equalTo: queryZip)
            query.findObjectsInBackgroundWithBlock{
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                progressBar.stopAnimation()
                if error == nil {
                    print("Successfully retrieved \(objects!.count) posts.")
                    
                    // if returned 0 match, display a notification
                    if objects?.count == 0 {
                        let notie = Notie(view: self.view, message: "No match found. Try another query.", style: .Confirm)
                        notie.leftButtonAction = {
                            self.dismissSelf()
                            notie.dismiss()
                        }
                        notie.rightButtonAction = {
                            notie.dismiss()
                        }
                        notie.show()
                    }
                    
                    // update the table view's data content
                    if let objects = objects {
                        self.rentalObjects = objects
                        self.tableView.reloadData()
                    }
                    //                if let objects = objects {
                    //                    for object in objects {
                    //                        print(object)
                    //                    }
                    //                }
                } else {
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        
        
        //------save search begin-----
        if saveSearch {
            searchCondition["zip"] = queryZip
            searchCondition["owner"] = userEmail
            searchCondition["city"] = queryCity
            
            searchCondition["scheduleType"] = scheduleType
            if scheduleType == 1 {
                nextPushTime += AppConstants.oneDayTimeInMiliSecond
            } else if scheduleType == 2 {
                nextPushTime += AppConstants.oneDayTimeInMiliSecond * 7
            }
            searchCondition["nextPushTime"] = nextPushTime
            print("begin to save")
            searchCondition.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("saved on cloud")
                } else {
                    // There was a problem, check error.description
                    print(error?.description)
                }
            }
        }
        //------save search end -----
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // method to dismiss this view itself, called when `done` button clicked
    func dismissSelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentalObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RentalCell", forIndexPath: indexPath) as! RentalCell
        
        let rental = rentalObjects[indexPath.row]
        matchRentalObjectWithRentalCell(cell, rental: rental)
        return cell
    }
    
    func matchRentalObjectWithRentalCell(cell: RentalCell, rental: PFObject) {
        // for date label
        if let date = rental.valueForKey("date") as? NSDate {
            let df = NSDateFormatter()
            df.dateStyle = .MediumStyle
            df.timeStyle = .NoStyle
            let dateStr = df.stringFromDate(date)
            //cell.dateLabel.text = "Date: \(dateStr)"
            cell.dateLabel.text = dateStr
        }
        // for type label: including type + bed# & bath#
        let type = rental.valueForKey("type") as! String
        let bedCnt = Util.strToNum(rental.valueForKey("bedroomCnt") as! String)
        let bathCnt = Util.strToNum(rental.valueForKey("bathCnt") as! String)
        cell.typeLabel.text = "\(type) \(bedCnt)B\(bathCnt)B"
        // for image view
        cell.rentalImageView.image = UIImage(named: "placeholder")
        if let file = rental.valueForKey("imageFile") as? PFFile {
            cell.rentalImageView.file = file
            cell.rentalImageView.loadInBackground()
        }
        // for rent label
        cell.rentLabel.text = "$" + String(format: "%.0f", rental.valueForKey("rent") as! Double)
        // for address1 label: street
        cell.address1Label.text = rental.valueForKey("street") as? String
        // for address2 label: city, state, zip and country
        let city = rental.valueForKey("city") as! String
        let state = rental.valueForKey("state1") as! String
        let zip = rental.valueForKey("zip") as! String
        //let country = rental.valueForKey("country") as! String
        cell.address2Label.text = "\(city) \(state) \(zip)"
        // for phone lable
        cell.phoneLabel.text = rental.valueForKey("phone") as? String
        
        
        // for extra fields in RentalCell; to be consumed by detail VC
        cell.bathCnt = bathCnt
        cell.bedCnt = bedCnt
        cell.type = type
        cell.des = rental.valueForKey("description1") as! String
        cell.footage = rental.valueForKey("footage") as! Double
        cell.email = rental.valueForKey("email") as! String
        cell.pageView = rental.valueForKey("pageView") as! Int
        cell.favedBy = rental.valueForKey("favedBy") as! [String]
    }
    
    // pass the selected UITableViewCell to the detail VC so info can be displayed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tenantSegue" {
            let index = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRowAtIndexPath(index!) as! RentalCell
            let controller = segue.destinationViewController as! DetailForTenantViewController
            
            controller.cell = cell
            
            // increment the page view field
            let object = rentalObjects[index!.row]
            object.incrementKey("pageView")
            object.saveInBackground()
            controller.objRef = object
        }
    }
    
}