//
//  AddCategoryVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/11/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController, ColorDelegate {
    
    let cancelButton = TextButton()
    let doneButton = TextButton()
    let categoryView = CategoryView()
    let titleInput = InputField()
    let colorPicker = ColorPicker()
    
    var selectedColor = UIColor.lightGray

    override func viewDidLoad() {
        super.viewDidLoad()

        layoutSystemButtons()
        layoutCategoryForm()
        layoutColorPicker()
        
    }
    
    @objc func cancelPressed(sender: TextButton!) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func donePressed(sender: TextButton!) {
        
        if titleInput.text != "" {
            
            let newCategory = Category(context: context)
            newCategory.title = titleInput.text!
            newCategory.color = selectedColor
            
            ad.saveContext()
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Missing Title", message: "Please input a title for this category.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    func pickedColor(color: UIColor) {
        
        categoryView.backgroundColor = color
        selectedColor = color
        
    }
}
