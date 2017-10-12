//
//  InputField.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class InputField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.font = Shared.displayFont
        
    }
    
    func addLabel(title: String) {
        
        let titleLabel = UILabel()
        
        titleLabel.font = Shared.smallFont
        titleLabel.textColor = UIColor.lightGray
        titleLabel.text = title
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        
        let titleWidth = titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.width)
        let titleHeight = titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.frame.height)
        let titleX = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2)
        let titleY = titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        
        let titleConstraints = [titleWidth, titleHeight, titleX, titleY]
        
        NSLayoutConstraint.activate(titleConstraints)
        
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 6)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
