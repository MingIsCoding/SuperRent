//
//  TenantNavigationViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation

class TenantNavigationViewController: ENSideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: TenantMenuTableViewController(), menuPosition:.Left)
        sideMenu?.menuWidth = 180.0
        // show the navigation bar over the side menu view
        view.bringSubviewToFront(navigationBar)
    }
}