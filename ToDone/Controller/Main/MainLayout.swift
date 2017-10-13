//
//  MainLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension MainVC {
    
    func layoutMenuButtons() {
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
//        settingsButton.backgroundColor = UIColor.orange
        settingsButton.addTarget(self, action: #selector(MainVC.settingsPressed(sender:)), for: .touchUpInside)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
//        addButton.backgroundColor = UIColor.orange
        addButton.addTarget(self, action: #selector(MainVC.addPressed(sender:)), for: .touchUpInside)
        
        view.addSubview(settingsButton)
        view.addSubview(addButton)
        
        let settingsWidth = settingsButton.widthAnchor.constraint(equalToConstant: 30)
        let settingsHeight = settingsButton.heightAnchor.constraint(equalToConstant: 30)
        let settingsX = settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let settingsY = settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        
        let addWidth = addButton.widthAnchor.constraint(equalToConstant: 30)
        let addHeight = addButton.heightAnchor.constraint(equalToConstant: 30)
        let addX = addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let addY = addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        
        let buttonConstraints = [settingsWidth, settingsHeight, settingsX, settingsY,
                                 addWidth, addHeight, addX, addY]
        
        NSLayoutConstraint.activate(buttonConstraints)
        
    }
    
    func layoutToDoTable() {
        
        toDoTable.dataSource = self
        toDoTable.delegate = self
        toDoTable.separatorStyle = .none
        toDoTable.allowsMultipleSelection = false
        toDoTable.register(ToDoCell.self, forCellReuseIdentifier: "toDoCell")
        toDoTable.translatesAutoresizingMaskIntoConstraints = false
        toDoTable.rowHeight = 44
        toDoTable.clearsContextBeforeDrawing = true
        
        view.addSubview(toDoTable)
        
        let tableTop = toDoTable.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 10)
        let tableLeft = toDoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRight = toDoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let tableBottom = toDoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        let tableConstraints = [tableTop, tableLeft, tableRight, tableBottom]
        
        NSLayoutConstraint.activate(tableConstraints)
        
    }
}
