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
    
    @IBAction func toggleMenuButton(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if Util.checkUserEmail() == nil {
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
}