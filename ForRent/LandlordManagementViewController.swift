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
    
    @IBAction func toggleMenuButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        let query = PFQuery(className: "Rental")
        query.whereKey("loginEmail", equalTo: userEmail!)
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(objects!.count) posts.")
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
}