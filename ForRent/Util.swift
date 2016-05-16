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
    
    static func strToNum(str: String) -> Int {
        switch str {
        case "one":
            return 1
        case "two":
            return 2
        case "three":
            return 3
        case "four":
            return 4
        default:
            return 1
        }
    }
    
    static func numToStr(num: String) -> String {
        switch num {
        case "1":
            return "one"
        case "2":
            return "two"
        case "3":
            return "three"
        case "4":
            return "four"
        default:
            return "one"
        }
    }
    
    static func houseTypeConverter(types: Set<String>) -> Set<String> {
        var result = Set<String>()
        for type in types {
            switch type {
            case "🏡 House":
                result.insert("House")
            case "🏚 Townhouse":
                result.insert("Townhouse")
            case "🏢 Apartment":
                result.insert("Apartment")
            case "🏤 Condo":
                result.insert("Condo")
            default:
                break
            }
        }
        return result
    }
}