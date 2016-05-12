//
//  RentalCell.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/6/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation
import UIKit

class RentalCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rentalImageView: PFImageView!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    
    var bedCnt: Int!
    var bathCnt: Int!
    var type: String!
    var des: String!
    var footage: Double!
    var email: String!
}