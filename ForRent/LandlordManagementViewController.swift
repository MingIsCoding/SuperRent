//
//  LandlordManagementViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import Notie


class LandlordManagementViewController: UITableViewController {
    
    var userEmail: String?
    var rentalObjects: [PFObject] = []
    @IBOutlet var refreshButton: UIButton!
    
    @IBAction func refreshButtonClicked(sender: UIButton) {
        sender.hidden = true
        requestForData()
    }

    func toggleMenuButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 86
        
        self.navigationItem.title = "My Posts"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_60"), style: .Plain, target: self, action: #selector(LandlordManagementViewController.toggleMenuButton(_:)))
        
        // add a 'Edit' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(LandlordManagementViewController.toggleEdittingMode))
        
        checkLogin()
        refreshButton.hidden = true
        requestForData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // to reveal the tab bar, otherwise it'll remain hidden since it's hidden in the detail page
        self.tabBarController?.tabBar.hidden = false
    }
    
    func checkLogin() {
        if let value = Util.checkUserEmail() {
            userEmail = value
        } else {
            let notie = Notie(view: self.view, message: "Please sign in to manage your posts.", style: .Confirm)
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
    }
    
    func requestForData() {
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        let query = PFQuery(className: "Rental")
        query.whereKey("loginEmail", equalTo: userEmail!)
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            progressBar.stopAnimation()
            self.refreshButton.hidden = false
            if error == nil {
                print("Successfully retrieved \(objects!.count) posts.")
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentalObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RentalCell", forIndexPath: indexPath) as! RentalCell
        // reference for format of retrieved object
//            <Rental: 0x144ddbbc0, objectId: FAVhHIzVhv, localId: (null)> {
//            bathCnt = four;
//            bedroomCnt = four;
//            city = "San Jose";
//            country = US;
//            date = "2016-09-14 20:09:02 +0000";
//            description = "";
//            email = "michael@gmail.com";
//            imageFile = "<PFFile: 0x144f065a0>";
//            imageName = "Rental Image";
//            loginEmail = "chienshin1@gmail.com";
//            phone = "(480) 125-8863";
//            rent = 1250;
//            state1 = CA;
//            street = "458 Floyd Rd";
//            type = House;
//            zip = 95112;
//        }
        
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
        
        // for extra fields in RentalCell; to be consumed by detail VC
        cell.bathCnt = bathCnt
        cell.bedCnt = bedCnt
        cell.type = type
        cell.des = rental.valueForKey("description1") as! String
        cell.footage = rental.valueForKey("footage") as! Double
        cell.email = rental.valueForKey("email") as! String
        
        return cell
    }
    
    func toggleEdittingMode() {
        if editing {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            setEditing(false, animated: true)
        }
        else {
            self.navigationItem.rightBarButtonItem?.title = "Done"
            setEditing(true, animated: true)
        }
    }
    
    // delete feature
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let rentalToDelete = rentalObjects[indexPath.row]
            
            let title = "Delete Post"
            let message = "Are you sure you want to delete this rental posting?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
                self.rentalObjects.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                rentalToDelete.deleteInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if success {
                        let notie = Notie(view: self.view, message: "Rental posting deleted from the server.", style: .Confirm)
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
            })
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    // pass the selected UITableViewCell to the detail VC so info can be displayed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "landlordSegue" {
            let index = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRowAtIndexPath(index!) as! RentalCell
            (segue.destinationViewController as! DetailForLandlordViewController).cell = cell
        }
    }

}