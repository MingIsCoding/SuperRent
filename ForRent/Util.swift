//
//  Util.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/2/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation


class Util {
    static func checkUserEmail() -> String? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //        if let email = userDefaults.valueForKey("userEmail") {
        //            return email as? String
        //        } else {
        //            return nil
        //        }
        return userDefaults.valueForKey(AppConstants.userEmailKey) as? String
        
    }
    
    
    static func askForLoggingIn() {
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController as! TabBarViewController
        viewController.presentLoginView()
    }
}