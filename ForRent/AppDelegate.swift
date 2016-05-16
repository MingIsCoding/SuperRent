//
//  AppDelegate.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/18/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let notiftypes:UIUserNotificationType = UIUserNotificationType.Badge //| UIUserNotificationType.Alert //| UIUserNotificationType.Sound
        
        let notifiSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notiftypes,categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notifiSettings)
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            //$0.server = "https://8725dd4b.ngrok.io/parse"
            $0.server = "https://superrent.herokuapp.com/parse"

        }
        Parse.initializeWithConfiguration(configuration)
        
        // Initialize sign-in for Google
        GIDSignIn.sharedInstance().clientID = "428874353126-t91r9ghpgkr7nj1aplurn3ojfqe98310.apps.googleusercontent.com"
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // added for fb sdk
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
        
        // to add custom logic
        return handled
    }
    
    
    // added for google sdk
    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        
        let fromGoogle = GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        let fromFacebook = FBSDKApplicationDelegate.sharedInstance().application(
        application, openURL: url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
        
        if fromGoogle {
            return true
        } else if fromFacebook {
            return true
        }
        
        return false
    }
    
    
    


}

