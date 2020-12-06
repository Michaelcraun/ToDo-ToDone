//
//  TextButton.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class TextButton: UIButton {

    func addTitle(title: String, color: UIColor) {
        
        let titleLbl = UILabel()
        
        titleLbl.font = displayFont
        titleLbl.textColor = color
        titleLbl.text = title
        titleLbl.sizeToFit()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.frame = CGRect(x: self.frame.width / 2 - titleLbl.frame.width / 2,
                                y: self.frame.height / 2 - titleLbl.frame.height / 2,
                                width: titleLbl.frame.width,
                                height: titleLbl.frame.height)
        
        self.addSubview(titleLbl)
        
        let titleWidth = titleLbl.widthAnchor.constraint(equalToConstant: titleLbl.frame.width)
        let titleHeight = titleLbl.heightAnchor.constraint(equalToConstant: titleLbl.frame.height)
        let titleX = titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let titleY = titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let titleConstraints = [titleWidth, titleHeight, titleX, titleY]
        
        NSLayoutConstraint.activate(titleConstraints)
        
    }
}
