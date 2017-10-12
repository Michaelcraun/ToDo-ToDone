//
//  CategoryView.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
@IBDesignable

class CategoryView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame.size.width = 10
        self.frame.size.height = 10
        self.layer.cornerRadius = self.frame.height / 2
    }
}
