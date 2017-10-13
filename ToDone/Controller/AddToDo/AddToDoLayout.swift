//
//  AddToDoLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension AddToDoVC {
    
    func layoutSystemButtons() {
        
        cancelButton.addTarget(self, action: #selector(AddToDoVC.cancelPressed(sender:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTitle(title: "Cancel", color: UIColor.red)
        
        doneButton.addTarget(self, action: #selector(AddToDoVC.donePressed(sender:)), for: .touchUpInside)
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
    
    func layoutTitleInput() {
        
        titleInput.frame = CGRect(x: 10,
                                  y: 80,
                                  width: Shared.screenWidth - 20,
                                  height: 40)
        titleInput.addLabel(title: "ToDo:")
        
        view.addSubview(titleInput)
        
    }
    
    func layoutDeadlineInput() {
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItemStyle.plain,
                                         target: self,
                                         action: #selector(AddToDoVC.donePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: UIBarButtonItemStyle.plain,
                                           target: self,
                                           action: #selector(AddToDoVC.donePicker(sender:)))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM DD YYYY"
        
        deadlineInput.frame = CGRect(x: 10,
                                     y: 130,
                                     width: Shared.screenWidth - 20,
                                     height: 40)
        deadlineInput.addLabel(title: "Deadline:")
        
        deadlinePicker.datePickerMode = .date
        deadlinePicker.date = Date()
        deadlinePicker.addTarget(self, action: #selector(AddToDoVC.checkPicker(sender:)), for: .valueChanged)
        deadlinePicker.backgroundColor = UIColor.clear
        deadlinePicker.frame = CGRect(x: 0,
                                      y: toolbar.frame.height,
                                      width: Shared.screenWidth,
                                      height: 200)
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.items![0].tintColor = UIColor.red
        toolbar.items![2].tintColor = UIColor.green
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        pickerView.frame = CGRect(x: 0,
                                  y: Shared.screenHeight - 200 - toolbar.frame.height,
                                  width: Shared.screenWidth,
                                  height: 200 + toolbar.frame.height)
        
        deadlineInput.inputView = pickerView
        
        view.addSubview(deadlineInput)
        pickerView.addSubview(deadlinePicker)
        pickerView.addSubview(toolbar)
        
    }
    
    func layoutCategoryButton() {
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
            
            categories = objects
            selectedCateogry = categories[0]
            
        } else {
            
            selectedCateogry?.color = UIColor.clear
            selectedCateogry?.title = "Select a category"
            
        }
        
        categoryButton.frame = CGRect(x: 10,
                                      y: 180,
                                      width: Shared.screenWidth - 20,
                                      height: 30)
        categoryButton.addTarget(self, action: #selector(AddToDoVC.selectCategory(sender:)), for: .touchUpInside)
        
        categoryView.backgroundColor = selectedCateogry?.color as? UIColor
        categoryView.frame = CGRect(x: 10,
                                    y: categoryButton.frame.height / 2 - 5,
                                    width: 10,
                                    height: 10)
        
        categoryLabel.font = Shared.displayFont
        categoryLabel.text = selectedCateogry?.title
        categoryLabel.sizeToFit()
        categoryLabel.frame = CGRect(x: 30,
                                     y: categoryButton.frame.height / 2 - categoryLabel.frame.height / 2,
                                     width: categoryButton.frame.width - 40,
                                     height: categoryLabel.frame.height)
        
        view.addSubview(categoryButton)
        categoryButton.addSubview(categoryView)
        categoryButton.addSubview(categoryLabel)
        
    }
    
    func layoutSubToDoTable() {
        
        subToDoTable.dataSource = self
        subToDoTable.delegate = self
        subToDoTable.separatorStyle = .none
        subToDoTable.allowsMultipleSelection = false
        subToDoTable.register(SubToDoCell.self, forCellReuseIdentifier: "subToDoCell")
        subToDoTable.rowHeight = 30
        subToDoTable.frame = CGRect(x: 0,
                                    y: 220,
                                    width: Shared.screenWidth,
                                    height: Shared.screenHeight - 200)
        
        view.addSubview(subToDoTable)
        
    }
}
