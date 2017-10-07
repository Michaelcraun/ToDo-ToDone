//
//  MainLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension MainVC {
    
    func layoutView() {
        
        layoutMenuButtons()
        layoutToDoTable()
        
    }
    
    func layoutMenuButtons() {
        
        let settingsButton = UIButton()
        let addButton = UIButton()
        
        settingsButton.backgroundColor = UIColor.orange
        settingsButton.addTarget(self, action: #selector(MainVC.settingsPressed(sender:)), for: .touchUpInside)
        settingsButton.frame = CGRect(x: 10,
                                      y: 40,
                                      width: 30,
                                      height: 30)
        
        addButton.backgroundColor = UIColor.orange
        addButton.addTarget(self, action: #selector(MainVC.addPressed(sender:)), for: .touchUpInside)
        addButton.frame = CGRect(x: Shared.screenWidth - 40,
                                 y: 40,
                                 width: 30,
                                 height: 30)
        
        view.addSubview(settingsButton)
        view.addSubview(addButton)
        
    }
    
    func layoutToDoTable() {
        
        toDoTable.dataSource = self
        toDoTable.delegate = self
        toDoTable.separatorStyle = .none
        toDoTable.allowsMultipleSelection = false
        toDoTable.register(ToDoCell.self, forCellReuseIdentifier: "toDoCell")
        toDoTable.frame = CGRect(x: 0,
                                 y: 80,
                                 width: Shared.screenWidth,
                                 height: Shared.screenHeight - 80)
        
        view.addSubview(toDoTable)
        
    }
    
    func layoutSettingsPane() {
        
        
    }
}
