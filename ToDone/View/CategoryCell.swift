//
//  CategoryCell.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    func configurePurchaseCell() {
        
        let purchaseLabel = UILabel()
        
        purchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseLabel.font = Shared.displayFont
        purchaseLabel.textColor = UIColor.red
        purchaseLabel.text = "Purchase ToDone"
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
        addLabel.text = "Add Category"
        addLabel.sizeToFit()
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(addLabel)
        
        let addWidth = addLabel.widthAnchor.constraint(equalToConstant: addLabel.frame.width)
        let addHeight = addLabel.heightAnchor.constraint(equalToConstant: addLabel.frame.height)
        let addX = addLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let addY = addLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let addConstraints = [addWidth, addHeight, addX, addY]
        
        NSLayoutConstraint.activate(addConstraints)
        
    }
    
    func configureCell(category: Category) {
        
        let categoryView = CategoryView()
        let categoryLabel = UILabel()
        
        categoryView.backgroundColor = category.color as? UIColor
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        
        categoryLabel.text = category.title
        categoryLabel.font = Shared.displayFont
        categoryLabel.sizeToFit()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(categoryView)
        self.addSubview(categoryLabel)
        
        let viewWidth = categoryView.widthAnchor.constraint(equalToConstant: 10)
        let viewHeight = categoryView.heightAnchor.constraint(equalToConstant: 10)
        let viewX = categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        let viewY = categoryView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let labelLeft = categoryLabel.leadingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: 10)
        let labelRight = categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        let labelY = categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let cellConstraints = [viewWidth, viewHeight, viewX, viewY,
                               labelLeft, labelRight, labelY]
        
        NSLayoutConstraint.activate(cellConstraints)
        
    }

}
