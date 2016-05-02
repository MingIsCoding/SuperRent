//
//  TabBarViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/30/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import Notie

class TabBarViewController: UITabBarController, LoginViewControllerDelegate {
    
    var userAsGuest: Bool = false
    var userLoggedIn: Bool = false
    var userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSUserDefaults.standardUserDefaults().removeObjectForKey("asGuest")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if userDefaults.objectForKey("asGuest") != nil {
            userAsGuest = userDefaults.boolForKey("asGuest")
        }
        
        if userDefaults.objectForKey("loginUserEmail") != nil {
            userLoggedIn = true
        }
        
        // login view will not be presented if user indicates to `continue as guest`
        if !userAsGuest && !userLoggedIn {
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
    func loggedIn(loginMethod: String, loginUserEmail: String?, loginUserName: String?) {
        if loginMethod != "guest" {
            userDefaults.setBool(false, forKey: "asGuest")
            userDefaults.setValue(loginUserEmail, forKey: "loginUserEmail")
            userDefaults.setValue(loginUserName, forKey: "loginUserName")
            userDefaults.synchronize()
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if loginMethod != "guest" {
            let notie = Notie(view: self.view, message: "Signed in through \(loginMethod)\nas \(loginUserName!) (\(loginUserEmail!))", style: .Confirm)
            notie.leftButtonAction = {
                notie.dismiss()
            }
            
            notie.rightButtonAction = {
                notie.dismiss()
            }
            notie.show()
        }
    }
}