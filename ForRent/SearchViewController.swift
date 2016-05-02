//
//  SearchViewController.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import LocationPicker

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func toggleSideMenuButtonClicked(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func locationButtonClicked(sender: AnyObject) {
        let customLocationPicker = LocationPicker()
        let navigationController = UINavigationController(rootViewController: customLocationPicker)
        presentViewController(navigationController, animated: true, completion: nil)
        
    }

}