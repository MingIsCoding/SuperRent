//
//  SearchResultViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/8/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit

class SearchResultViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "Results"
        
        // add a 'Done' button in the navigation bar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(SearchResultViewController.dismissSelf))
    }
    
    // method to dismiss this view itself, called when `done` button clicked
    func dismissSelf() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}