//
//  AppConstants.swift
//  ForRent
//
//  Created by Jianxin Gao on 5/1/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation

struct AppConstants {
    static let guestKey = "asGuest"
    static let userEmailKey = "userEmail"
    static let userNamekey = "userName"
    
    struct LoginMethod {
        static let Google = "Google"
        static let Facebook = "Facebook"
        static let Guest = "Guest"
    }
    
    static let oneDayTimeInMiliSecond: Double = 24 * 60 * 60 * 1000
}