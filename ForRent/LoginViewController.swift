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
import Parse

class LoginViewController: PFLogInViewController, GIDSignInUIDelegate {
    

    @IBOutlet weak var launchImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //launchImage.image = UIImage(named: "launch.png")
        //launchImage.contentMode = UIViewContentMode.ScaleToFill
        
//        let loginButton = FBSDKLoginButton()
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
        
        // for Google
        GIDSignIn.sharedInstance().uiDelegate = self
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
    }
}
