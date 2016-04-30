//
//  TabBarViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/30/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation

class TabBarViewController: UITabBarController, LoginViewControllerDelegate {
    
    var userAsGuest: Bool = false
    var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if userDefaults.objectForKey("asGuest") != nil {
            userAsGuest = userDefaults.boolForKey("asGuest")
        }
        
        // login view will not be presented if user indicates to `continue as guest`
        if !userAsGuest {
            presentLoginView()
        }
    }
    
    // present the login view
    func presentLoginView() {
        let loginView = self.storyboard?.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
        loginView.delegate = self
        self.presentViewController(loginView, animated: true, completion: nil)
    }
    
    // for log in view controller delegate
    func loggedIn(method: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}