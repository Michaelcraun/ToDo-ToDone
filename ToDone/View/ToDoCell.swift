//
//  ToDoCell.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    func clearCell() {
        let subviews = self.subviews
        for subview in subviews { subview.removeFromSuperview() }
    }
    
    func configureCell(toDo: ToDo) {
        let categoryView = CategoryView()
        let titleLbl = UILabel()
        let percentageLabel = UILabel()
        let progressBar = UIView()
        let completedBar = UIView()
        
        let progressAsCGFloat = CGFloat(toDo.completed)
        
        categoryView.backgroundColor = toDo.category?.color as? UIColor
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        
        percentageLabel.font = displayFont
        percentageLabel.textAlignment = .right
        percentageLabel.text = "\(toDo.completed)%"
        percentageLabel.sizeToFit()
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLbl.font = displayFont
        titleLbl.text = toDo.title
        titleLbl.sizeToFit()
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        progressBar.backgroundColor = UIColor.black
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        
        completedBar.backgroundColor = toDo.category?.color as? UIColor
        completedBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(categoryView)
        self.addSubview(percentageLabel)
        self.addSubview(titleLbl)
        self.addSubview(completedBar)
        self.addSubview(progressBar)
        
        let categoryWidth = categoryView.widthAnchor.constraint(equalToConstant: 10)
        let categoryHeight = categoryView.heightAnchor.constraint(equalToConstant: 10)
        let categoryY = categoryView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let categoryLeft = categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        
        let percentageHeight = percentageLabel.heightAnchor.constraint(equalToConstant: percentageLabel.frame.height)
        let percentageWidth = percentageLabel.widthAnchor.constraint(equalToConstant: 40)
        let percentageRight = percentageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        let percentageY = percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        
        let titleLeft = titleLbl.leadingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: 10)
        let titleRight = titleLbl.trailingAnchor.constraint(equalTo: percentageLabel.leadingAnchor, constant: -10)
        let titleY = titleLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: titleLbl.frame.height / 2 - 15)
        
        let progressLeft = progressBar.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor)
        let progressRight = progressBar.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor)
        let progressHeight = progressBar.heightAnchor.constraint(equalToConstant: 2)
        let progressY = progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10)
        
        let completedLeft = completedBar.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor)
        let completedHeight = completedBar.heightAnchor.constraint(equalToConstant: 5)
        let completedWidth = completedBar.widthAnchor.constraint(equalTo: progressBar.widthAnchor, multiplier: progressAsCGFloat * 0.01)
        let completedY = completedBar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 8.5)
        
        let viewConstraints = [categoryWidth, categoryHeight, categoryY, categoryLeft,
                               percentageHeight, percentageWidth, percentageRight, percentageY,
                               titleLeft, titleRight, titleY,
                               progressLeft, progressRight, progressHeight, progressY,
                               completedLeft, completedHeight, completedWidth, completedY]
        
        NSLayoutConstraint.activate(viewConstraints)
        
        self.bringSubview(toFront: completedBar)
        
    }
}
