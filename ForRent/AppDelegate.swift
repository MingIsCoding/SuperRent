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
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.server = "https://superrent.herokuapp.com/parse"
        }
        Parse.initializeWithConfiguration(configuration)
        
        // Initialize sign-in for Google
        GIDSignIn.sharedInstance().clientID = "428874353126-t91r9ghpgkr7nj1aplurn3ojfqe98310.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        
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
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    // added for google sdk
    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url, sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String, annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print("userId: \(userId) \n")
            print("idToken: \(idToken) \n")
            print("fullName: \(fullName) \n")
            print("givenName: \(givenName) \n")
            print("familyName: \(familyName) \n")
            print("email: \(email) \n")
            
            NSNotificationCenter.defaultCenter().postNotificationName(
                "ToggleAuthUINotification",
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    // [START disconnect_handler]
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // [START_EXCLUDE]
        NSNotificationCenter.defaultCenter().postNotificationName(
            "ToggleAuthUINotification",
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
        // [END_EXCLUDE]
    }
    // [END disconnect_handler]


}

