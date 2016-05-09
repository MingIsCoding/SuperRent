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
        
        // do the query
        let query = PFQuery(className: "Rental")
        if let keyword = queryKeyword {
            query.whereKey("description", containsString: keyword)
        }
        if let types = queryTypes {
            print(types)
            query.whereKey("type", containedIn: types)
        }
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
                if let objects = objects {
                    for object in objects {
                        print(object)
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
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
        
        return cell
    }
    
}