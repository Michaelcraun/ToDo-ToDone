//
//  AddDetailsVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

class AddDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK: CoreData Variables
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
    
    let cancelButton = TextButton()
    let doneButton = TextButton()
    let categoryTable = UITableView()
    let titleInput = InputField()

    var transition = ""
    var addingNewCategory = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptCategoryFetch()
        layoutSystemButtons()
        
        if transition == "addCategory" {
            
            layoutCategoryTable()
            
        } else {
            
            layoutNewSubToDoForm()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        attemptCategoryFetch()
        categoryTable.reloadData()
        
    }
    
    @objc func cancelPressed(sender: TextButton!) {
        
        Shared.createdSubToDo = nil
        Shared.selectedCategory = nil
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func donePressed(sender: TextButton!) {
        
        if transition == "addSubToDo" {
            
            if titleInput.text != "" {
                
                let newSubToDo = SubToDo(context: context)
                newSubToDo.title = titleInput.text
                newSubToDo.completed = false
                newSubToDo.dateAdded = Date()
                
                Shared.createdSubToDo = newSubToDo
                
                dismiss(animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Missing Title", message: "Please input a title for this SubToDo.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alert, animated: true, completion: nil)
                
            }
        }
        
        if Shared.selectedCategory != nil {
            
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    //MARK: Setup for categoryTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfCategories = 0
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
            
            numOfCategories = objects.count
            
        }
        
        return numOfCategories
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
                
            cell.configureCell(category: objects[indexPath.row])
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
                
            Shared.selectedCategory = objects[indexPath.row]
            
        }
        
        categoryTable.deselectRow(at: indexPath, animated: true)
        
    }
}
