//
//  SettingsCoreData.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import CoreData

extension SettingsVC {
    
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
