//
//  LandlordNavigationViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/30/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation

class LandlordNavigationViewController: ENSideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: LandlordMenuTableViewController(), menuPosition:.Left)
        // show the navigation bar over the side menu view
        view.bringSubviewToFront(navigationBar)
    }
}