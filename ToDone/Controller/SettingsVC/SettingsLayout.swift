//
//  SettingsLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension SettingsVC {
    
    func layoutCategoryTable() {
        
        categoryTable.dataSource = self
        categoryTable.delegate = self
        categoryTable.separatorStyle = .none
        categoryTable.allowsMultipleSelection = false
        categoryTable.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1)
        categoryTable.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
        categoryTable.translatesAutoresizingMaskIntoConstraints = false
        categoryTable.rowHeight = 30
        
        view.addSubview(categoryTable)
        
        let tableTop = categoryTable.topAnchor.constraint(equalTo: view.topAnchor)
        let tableBottom = categoryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let tableLeft = categoryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableWidth = categoryTable.widthAnchor.constraint(equalToConstant: 250)
        
        let tableConstraints = [tableTop, tableBottom, tableLeft, tableWidth]
        
        NSLayoutConstraint.activate(tableConstraints)
        
    }
}
