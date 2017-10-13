//
//  SubToDoCell.swift
//  ToDone
//
//  Created by Michael Craun on 10/8/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class SubToDoCell: UITableViewCell {
    
    func clearCell() {
        
        let subviews = self.subviews
        
        for subview in subviews {
            
            subview.removeFromSuperview()
            
        }
    }
    
    func configurePurchaseCell() {
        
        let purchaseLabel = UILabel()
        
        purchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseLabel.font = Shared.displayFont
        purchaseLabel.textColor = UIColor.red
        purchaseLabel.text = "Purchase ToDo ToDone"
        purchaseLabel.sizeToFit()
        
        self.addSubview(purchaseLabel)
        
        let purchaseWidth = purchaseLabel.widthAnchor.constraint(equalToConstant: purchaseLabel.frame.width)
        let purchaseHeight = purchaseLabel.heightAnchor.constraint(equalToConstant: purchaseLabel.frame.height)
        let purchaseX = purchaseLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let purchaseY = purchaseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let purchaseConstraints = [purchaseWidth, purchaseHeight, purchaseX, purchaseY]
        
        NSLayoutConstraint.activate(purchaseConstraints)
        
    }

    func configureAddCell() {
        
        let addLabel = UILabel()
        
        addLabel.font = Shared.displayFont
        addLabel.textColor = UIColor.green
        addLabel.text = "Add SubToDo"
        addLabel.sizeToFit()
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(addLabel)
        
        let addX = addLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let addY = addLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let addConstraints = [addX, addY]
        
        NSLayoutConstraint.activate(addConstraints)
        
    }

    func configureCell(subToDo: SubToDo) {
        
        let completedView = UIView()
        let subToDoLabel = UILabel()
        
        completedView.layer.cornerRadius = 7.5
        completedView.layer.borderColor = UIColor.black.cgColor
        completedView.layer.borderWidth = 1
        completedView.translatesAutoresizingMaskIntoConstraints = false
        
        if !subToDo.completed {
            
            completedView.backgroundColor = UIColor.white
            subToDoLabel.textColor = UIColor.black
            
        } else {
            
            completedView.backgroundColor = UIColor.green
            subToDoLabel.textColor = UIColor.lightGray
            
        }
        
        subToDoLabel.font = Shared.displayFont
        subToDoLabel.text = subToDo.title
        subToDoLabel.sizeToFit()
        subToDoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(subToDoLabel)
        self.addSubview(completedView)
        
        let completedWidth = completedView.widthAnchor.constraint(equalToConstant: 15)
        let completedHeight = completedView.heightAnchor.constraint(equalToConstant: 15)
        let completedX = completedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        let completedY = completedView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let labelLeft = subToDoLabel.leadingAnchor.constraint(equalTo: completedView.trailingAnchor, constant: 10)
        let labelRight = subToDoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        let labelY = subToDoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let labelConstraints = [completedX, completedY, completedWidth, completedHeight,
                                labelLeft, labelRight, labelY]
        
        NSLayoutConstraint.activate(labelConstraints)
        
    }
}
