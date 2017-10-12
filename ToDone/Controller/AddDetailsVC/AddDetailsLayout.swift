//
//  AddDetailsLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension AddDetailsVC {
    
    func layoutSystemButtons() {
        
        cancelButton.addTarget(self, action: #selector(AddDetailsVC.cancelPressed(sender:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTitle(title: "Cancel", color: UIColor.red)
        
        doneButton.addTarget(self, action: #selector(AddDetailsVC.donePressed(sender:)), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTitle(title: "Done", color: UIColor.green)
        
        view.addSubview(cancelButton)
        view.addSubview(doneButton)
        
        let cancelWidth = cancelButton.widthAnchor.constraint(equalToConstant: 50)
        let cancelHeight = cancelButton.heightAnchor.constraint(equalToConstant: 30)
        let cancelTop = cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        let cancelLeft = cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        
        let doneWidth = doneButton.widthAnchor.constraint(equalToConstant: 50)
        let doneHeight = doneButton.heightAnchor.constraint(equalToConstant: 30)
        let doneTop = doneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        let doneRight = doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        
        let viewConstraints = [cancelWidth, cancelHeight, cancelTop, cancelLeft,
                               doneWidth, doneHeight, doneTop, doneRight]
        
        NSLayoutConstraint.activate(viewConstraints)
        
    }
    
    func layoutCategoryTable() {
        
        categoryTable.dataSource = self
        categoryTable.delegate = self
        categoryTable.separatorStyle = .none
        categoryTable.allowsMultipleSelection = false
        categoryTable.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
        categoryTable.rowHeight = 30
        categoryTable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(categoryTable)
        
        let tableTop = categoryTable.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10)
        let tableBottom = categoryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let tableLeft = categoryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRight = categoryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        let tableConstraints = [tableTop, tableBottom, tableLeft, tableRight]
        
        NSLayoutConstraint.activate(tableConstraints)
        
    }
    
    func layoutNewSubToDoForm() {
        
        titleInput.font = Shared.displayFont
        titleInput.translatesAutoresizingMaskIntoConstraints = false
        titleInput.addLabel(title: "SubToDo:")
        
        view.addSubview(titleInput)
        
        let titleTop = titleInput.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10)
        let titleLeft = titleInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let titleRight = titleInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let titleHeight = titleInput.heightAnchor.constraint(equalToConstant: 40)
        
        let titleConstraints = [titleTop, titleLeft, titleRight, titleHeight]
        
        NSLayoutConstraint.activate(titleConstraints)
        
    }
}
