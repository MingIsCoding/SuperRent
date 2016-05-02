//
//  AccountViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation

class AccountViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let email = userDefaults.valueForKey(AppConstants.userEmailKey) {
            let name = userDefaults.valueForKey(AppConstants.userNamekey) as! String
            userLabel.text = name + " (" + (email as! String) + ")"
        }
    }
    @IBAction func toggleButton(sender: AnyObject) {
        toggleSideMenuView()
    }
}