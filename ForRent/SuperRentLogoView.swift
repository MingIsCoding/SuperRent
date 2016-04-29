//
//  SuperRentLogoView.swift
//  ForRent
//
//  Created by Jianxin Gao on 4/28/16.
//  Copyright © 2016 sjsu. All rights reserved.
//

import Foundation


class SuperRentLogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "banner"))
        imageView.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.autoresizingMask = .FlexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.contentMode = .ScaleAspectFit
        self.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}