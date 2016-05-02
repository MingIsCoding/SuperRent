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

@objc protocol LoginViewControllerDelegate: class {
    // delegate method for Login VC to call when the user finishes logging in
    // to dismiss itself (login VC); implemented by TabBarVC
    @objc optional func loggedIn(loginMethod: String, loginUserEmail: String?, loginUserName: String?)
}

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var fbSDKLoginManager: FBSDKLoginManager!
    var delegate: LoginViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbSDKLoginManager = FBSDKLoginManager.init()
        GIDSignIn.sharedInstance().delegate = self
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            // user is logged in
            print("user is logged in already (facebook); " + token.userID)
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
                self.fbLoginViewError(result, error: error)
            } else if result.isCancelled {
                print("Facebook login cancelled")
                self.fbLoginViewError(result, error: error)
            } else {
                print("Facebook logged in")
                self.fbLoggedInUser(result)
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
            print("fullName: \(fullName)")
            print("givenName: \(givenName)")
            print("familyName: \(familyName)")
            print("email: \(email) \n")
            
            self.delegate.loggedIn!("Google", loginUserEmail: email, loginUserName: fullName)
            
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
                let id = result.valueForKey("id") as? String
                let name = result.valueForKey("name") as? String
                let email = result.valueForKey("email") as? String
                print("graph request result: \n")
                print(id)
                print(name)
                print(email)
                self.delegate.loggedIn!("Facebook", loginUserEmail: email, loginUserName: name)
                
            }
        })
    }
    
    func fbLoggedOutUser(){
        
    }
    
    func fbLoginViewError(loginResult:FBSDKLoginManagerLoginResult?, error:NSError?){
        
    }
  
    @IBAction func continueButtonClicked(sender: UIButton) {
        delegate.loggedIn!("guest", loginUserEmail: "", loginUserName: "")
        
        // save this info in the NSUserDefaults, otherwise the login view will keep poping up from the tab bar controller
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(true, forKey: "asGuest")
        userDefaults.synchronize()
    }
    

}
