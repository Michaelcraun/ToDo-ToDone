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
    
    func generateTestData() {
        
        let home = Category(context: context)
        home.title = "Home"
        home.color = UIColor.blue
        
        let general = Category(context: context)
        general.title = "General"
        general.color = UIColor.lightGray
        
        let socialAndFamily = Category(context: context)
        socialAndFamily.title = "Social & Family"
        socialAndFamily.color = UIColor.orange
        
        let dishes = SubToDo(context: context)
        dishes.title = "Dishes"
        dishes.completed = false
        
        let laundry = SubToDo(context: context)
        laundry.title = "Laundry"
        dishes.completed = false
        
        let chores = ToDo(context: context)
        chores.title = "Chores"
        chores.completed = 33
        chores.category = home
        chores.deadline = Date()
        chores.addToSubToDo(dishes)
        
        let familyMeeting = ToDo(context: context)
        familyMeeting.title = "Family Meeting"
        familyMeeting.completed = 20
        familyMeeting.category = socialAndFamily
        familyMeeting.deadline = Date()
        
        let drinkWater = ToDo(context: context)
        drinkWater.title = "Drink 8 bottles of water per day"
        drinkWater.completed = Int16((3/8) * 100)
        drinkWater.category = general
        drinkWater.deadline = Date()
        
        ad.saveContext()
        
    }
    
    func attemptToDoFetch() {
        
        let dateSort = NSSortDescriptor(key: "dateAdded", ascending: true)
        //TODO: Add category sort
        
        toDoFetchRequest.sortDescriptors = [dateSort]
        
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
}
