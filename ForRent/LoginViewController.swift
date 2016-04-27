//
//  LoginViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/26/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var launchImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        launchImage.image = UIImage(named: "launch.png")
        launchImage.contentMode = UIViewContentMode.ScaleToFill
    }
}
