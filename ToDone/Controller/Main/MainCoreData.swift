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
        
        let chores = ToDo(context: context)
        chores.title = "Chores"
        chores.completed = 33
        chores.category = home
        
        let familyMeeting = ToDo(context: context)
        familyMeeting.title = "Family Meeting"
        familyMeeting.completed = 20
        familyMeeting.category = socialAndFamily
        
        let drinkWater = ToDo(context: context)
        drinkWater.title = "Drink 8 bottles of water per day"
        drinkWater.completed = 38
        drinkWater.category = general
        
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
}
