//
//  ToDoCell.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    func configureCell(toDo: ToDo) {
        
        let categoryView = CategoryView()
        let titleLbl = UILabel()
        let percentageLabel = UILabel()
        let progressBar = UIView()
        let completedBar = UIView()
        
        let toDoColor = toDo.category?.color as? UIColor
        
        categoryView.backgroundColor = toDoColor
        categoryView.frame = CGRect(x: 10,
                                    y: self.frame.height / 2 - 5,
                                    width: 10,
                                    height: 10)
        
        percentageLabel.font = UIFont(name: "Arial", size: 15)
        percentageLabel.textAlignment = .right
        percentageLabel.text = "\(toDo.completed)%"
        percentageLabel.sizeToFit()
        percentageLabel.frame = CGRect(x: self.frame.width - 10,
                                       y: self.frame.height / 2 - percentageLabel.frame.height / 2,
                                       width: 50,
                                       height: percentageLabel.frame.height)
        
        titleLbl.font = UIFont(name: "Arial", size: 15)
        titleLbl.text = toDo.title
        titleLbl.sizeToFit()
        titleLbl.frame = CGRect(x: 20 + categoryView.frame.width,
                                y: self.frame.height / 2 - titleLbl.frame.height / 2 - 5,
                                width: titleLbl.frame.width,
                                height: titleLbl.frame.height)
        
        progressBar.backgroundColor = UIColor.black
        progressBar.frame = CGRect(x: 30,
                                   y: self.frame.height / 2 - progressBar.frame.height / 2 + 10,
                                   width: self.frame.width - 40,
                                   height: 2)
        
        let progressAsCGFloat = CGFloat(toDo.completed)
        completedBar.backgroundColor = toDoColor
        completedBar.frame = CGRect(x: progressBar.frame.minX,
                                    y: progressBar.frame.minY - 3,
                                    width: (progressBar.frame.width * (progressAsCGFloat * 0.01)),
                                    height: 5)
        
        self.addSubview(categoryView)
        self.addSubview(titleLbl)
        self.addSubview(percentageLabel)
        self.addSubview(progressBar)
        self.addSubview(completedBar)
        
    }
}
