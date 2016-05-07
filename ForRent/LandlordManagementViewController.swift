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

    func toggleMenuButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 68
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "My Posts"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_60"), style: .Plain, target: self, action: #selector(LandlordManagementViewController.toggleMenuButton(_:)))
        
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
        
        let progressBar = LinearProgressBar()
        self.view.addSubview(progressBar)
        progressBar.startAnimation()
        
        let query = PFQuery(className: "Rental")
        query.whereKey("loginEmail", equalTo: userEmail!)
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in

            progressBar.stopAnimation()
            if error == nil {
                print("Successfully retrieved \(objects!.count) posts.")
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
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rentalObjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RentalCell", forIndexPath: indexPath) as! RentalCell
        
        let rental = rentalObjects[indexPath.row]
        cell.address1Label.text = rental.valueForKey("date") as? String
        cell.typeLabel.text = rental.valueForKey("type") as? String
        return cell
    }
}