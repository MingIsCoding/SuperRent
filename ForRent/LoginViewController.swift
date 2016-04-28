//
//  LoginViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/26/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var fbSDKLoginManager: FBSDKLoginManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbSDKLoginManager = FBSDKLoginManager.init()
        GIDSignIn.sharedInstance().delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            // user is logged in
            print("user is logged in already; " + token.userID)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    @IBAction func googleButtonTouched(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func facebookButtonTouched(sender: AnyObject) {
        FBSDKProfile.enableUpdatesOnAccessTokenChange(false)
        self.fbSDKLoginManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: nil) { (result, error) -> Void in
            if (error != nil) {
                print("Facebook login error")
                print(error.localizedDescription)
                self.fbLoginViewError(result, error: error)
            } else if result.isCancelled {
                print("Facebook login cancelled")
                self.fbLoginViewError(result, error: error)
            } else {
                print("Facebook logged in")
                self.fbLoggedInUser(result)
                print(result.description)
            }
            
        }
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
    
    @objc func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    @objc func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        
    }
    
    //Facebook Delegates
    func fbLoggedInUser(loginResult:FBSDKLoginManagerLoginResult){
        let params = ["fields": "id, name, first_name, last_name, email"]
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({
            (connection, result, error) -> Void in
            if error != nil {
                print("Error: \(error)")
            }
            else {
                print("graph request result: \n")
                print(result.valueForKey("id") as? String)
                print(result.valueForKey("name"))
                print(result.valueForKey("email"))
            }
        })
    }
    
    func fbLoggedOutUser(){
        
    }
    
    func fbLoginViewError(loginResult:FBSDKLoginManagerLoginResult?, error:NSError?){
        
    }
  
    

}
