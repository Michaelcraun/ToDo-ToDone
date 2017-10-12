//
//  AddCategoryLayout.swift
//  ToDone
//
//  Created by Michael Craun on 10/11/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

extension AddCategoryVC {
    
    func layoutSystemButtons() {
        
        cancelButton.addTitle(title: "Cancel", color: UIColor.red)
        cancelButton.addTarget(self, action: #selector(AddCategoryVC.cancelPressed(sender:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        doneButton.addTitle(title: "Done", color: UIColor.green)
        doneButton.addTarget(self, action: #selector(AddCategoryVC.donePressed(sender:)), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        let buttonConstraints = [cancelWidth, cancelHeight, cancelTop, cancelLeft,
                                 doneWidth, doneHeight, doneTop, doneRight]
        
        NSLayoutConstraint.activate(buttonConstraints)
        
    }
    
    func layoutCategoryForm() {
        
        categoryView.backgroundColor = UIColor.lightGray
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        
        titleInput.addLabel(title: "Title")
        titleInput.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(categoryView)
        view.addSubview(titleInput)
        
        let categoryWidth = categoryView.widthAnchor.constraint(equalToConstant: 10)
        let categoryHeight = categoryView.heightAnchor.constraint(equalToConstant: 10)
        let categoryTop = categoryView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 20)
        let categoryLeft = categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        
        let titleLeft = titleInput.leadingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: 10)
        let titleRight = titleInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let titleTop = titleInput.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10)
        let titleHeight = titleInput.heightAnchor.constraint(equalToConstant: 40)
        
        let formConstraints = [categoryWidth, categoryHeight, categoryTop, categoryLeft,
                               titleLeft, titleRight, titleTop, titleHeight]
        
        NSLayoutConstraint.activate(formConstraints)
        
    }
    
    func layoutColorPicker() {
        
        colorPicker.delegate = self
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(colorPicker)
        
        let pickerTop = colorPicker.topAnchor.constraint(equalTo: titleInput.bottomAnchor, constant: 10)
        let pickerLeft = colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let pickerRight = colorPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        let pickerHeight = colorPicker.heightAnchor.constraint(equalToConstant: 40)
        
        let pickerConstraints = [pickerTop, pickerLeft, pickerRight, pickerHeight]
        
        NSLayoutConstraint.activate(pickerConstraints)
        
    }
}
