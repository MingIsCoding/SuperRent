//
//  PFLoginViewController.swift
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

class PFLoginViewController: PFLogInViewController, GIDSignInUIDelegate {
    
    
    var launchImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchImage = UIImageView(image: UIImage(named: "launch.png"))
        launchImage.contentMode = UIViewContentMode.ScaleToFill
        self.logInView!.insertSubview(launchImage, atIndex: 0)
        
        // customize the logo displayed
        let appLogo = UILabel()
        appLogo.text = "SuperRent"
        appLogo.textColor = UIColor.whiteColor()
        appLogo.font = UIFont(name: "Chewy", size: 60)
        logInView?.logo = appLogo
        
        logInView?.usernameField?.hidden = true
        logInView?.passwordField?.hidden = true
        logInView?.logInButton?.hidden = true
        logInView?.passwordForgottenButton?.hidden = true
        logInView?.signUpButton?.hidden = true
        fields = (
            PFLogInFields.Facebook
        )
        
        emailAsUsername = false
        
        
        
        //        let loginButton = FBSDKLoginButton()
        //        loginButton.center = self.view.center
        //        self.view.addSubview(loginButton)
        
        // for Google
        GIDSignIn.sharedInstance().uiDelegate = self
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        let googleButton = GIDSignInButton()
        
        logInView!.insertSubview(googleButton, atIndex: 1)
        
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        logInView!.facebookButton?.translatesAutoresizingMaskIntoConstraints = false
        let centerXG = NSLayoutConstraint(item: logInView!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: googleButton, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let centerYG = NSLayoutConstraint(item: logInView!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: googleButton, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 50)
        
        //        let centerXFB = NSLayoutConstraint(item: logInView!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: logInView!.facebookButton, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        //
        //        let widthFB = NSLayoutConstraint(item: logInView!.facebookButton!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: googleButton, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        //
        //        let heightFB = NSLayoutConstraint(item: logInView!.facebookButton!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: googleButton, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        
        
        logInView!.addConstraints([centerXG, centerYG])
        
        
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let frameWidth = self.logInView!.frame.width
        let frameHeight = self.logInView!.frame.height
        
        // stretch the image
        launchImage.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        
        logInView!.logo!.sizeToFit()
        
    }
}
