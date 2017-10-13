//
//  AddToDoCoreData.swift
//  ToDone
//
//  Created by Michael Craun on 10/8/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

extension AddToDoVC {
    
    func loadData() {
        
        let subToDos = toDoToEdit?.subToDo?.allObjects as! [SubToDo]
        
        var dateString = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM DD, YYYY"
        dateFormatter.dateStyle = .long
        
        if let date = toDoToEdit?.deadline {

            deadline = date
            dateString = dateFormatter.string(from: date)
            
        }
        
        titleInput.text = toDoToEdit?.title
        deadlineInput.text = dateString
        selectedCateogry = toDoToEdit?.category
        categoryView.backgroundColor = toDoToEdit?.category?.color as? UIColor
        categoryLabel.text = toDoToEdit?.category?.title
        subToDoToEdit = subToDos.sorted { (subToDos1, subToDos2) -> Bool in
            
            if subToDos1.dateAdded == subToDos2.dateAdded {
                
                return subToDos1.dateAdded! < subToDos2.dateAdded!
                
            } else {
                
                return subToDos1.dateAdded! < subToDos2.dateAdded!
                
            }
        }
    }
    
    func attemptCategoryFetch() {
        
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        categoryFetchRequest.sortDescriptors = [titleSort]
        
        let controller = NSFetchedResultsController(fetchRequest: categoryFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.categoryController = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("Error: \(error)")
            
        }
    }
    
    func attemptSubToDoFetch() {
        
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        subToDoFetchRequest.sortDescriptors = [titleSort]
        
        let controller = NSFetchedResultsController(fetchRequest: subToDoFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.subToDoController = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("Error: \(error)")
            
        }
    }
}
