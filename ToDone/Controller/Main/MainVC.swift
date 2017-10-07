//
//  ViewController.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let toDoTable = UITableView()
    
    //MARK: CoreData Variables
    var toDoController: NSFetchedResultsController<ToDo>!
    let toDoFetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutView()
        firstLaunch()
        
        //MARK: Test Calls
        generateTestData()
        attemptToDoFetch()
        
    }
    
    func firstLaunch() {
        
        let defaults = UserDefaults.standard
        let hasRan = defaults.bool(forKey: "hasRan")
        
        if !hasRan {
            
            generateStartingData()
            defaults.set(true, forKey: "hasRan")
            
        }
        
    }
    
    @objc func settingsPressed(sender: UIButton!) {
        
        print("settingsPressed")
        
    }
    
    @objc func addPressed(sender: UIButton!) {
        
        print("addPressed")
        
    }
    
    //MARK: Handles toDoTable setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let objects = toDoController.fetchedObjects, objects.count > 0 {
            
            return objects.count
            
        } else {
            
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoCell
        
        if let objects = toDoController.fetchedObjects, objects.count > 0 {
            
            cell.configureCell(toDo: objects[indexPath.row])
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == toDoTable {
            
            toDoTable.deselectRow(at: indexPath, animated: true)
            
        }
    }
}

