//
//  MainCoreDataHelper.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

extension MainVC {
    
    func generateStartingData() {
        
        let general = Category(context: context)
        general.color = UIColor.blue
        general.title = "General"
        
        let home = Category(context: context)
        home.color = UIColor.brown
        home.title = "Home"
        
        let school = Category(context: context)
        school.color = UIColor.green
        school.title = "School"
        
        let socialAndFamily = Category(context: context)
        socialAndFamily.color = UIColor.magenta
        socialAndFamily.title = "Social & Family"
        
        let work = Category(context: context)
        work.color = UIColor.orange
        work.title = "Work"
        
        ad.saveContext()
        
    }
    
    func attemptToDoFetch() {
        
        let dateSort = NSSortDescriptor(key: "dateAdded", ascending: false)
        toDoFetchRequest.sortDescriptors = [dateSort]
        
        if Shared.selectedCategory != nil {
            
            let filter = Shared.selectedCategory?.title
            let predicate = NSPredicate(format: "category = %@", filter!)
            toDoFetchRequest.predicate = predicate
            
            Shared.selectedCategory = nil
            
        }
        
        let controller = NSFetchedResultsController(fetchRequest: toDoFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.toDoController = controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("Error: \(error)")
            
        }
    }
    
//    func attemptCategoryFetch() {
//        
//        let titleSort = NSSortDescriptor(key: "title", ascending: true)
//        categoryFetchRequest.sortDescriptors = [titleSort]
//        
//        let controller = NSFetchedResultsController(fetchRequest: categoryFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        controller.delegate = self
//        self.categoryController = controller
//        
//        do {
//            
//            try controller.performFetch()
//            
//        } catch {
//            
//            let error = error as NSError
//            print("Error: \(error)")
//            
//        }
//    }
}
