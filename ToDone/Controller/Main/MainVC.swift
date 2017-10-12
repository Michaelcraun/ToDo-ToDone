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
    
    //MARK: UI Variables
    let settingsButton = UIButton()
    let addButton = UIButton()
    let toDoTable = UITableView()
    
    //MARK: CoreData Variables
    var toDoController: NSFetchedResultsController<ToDo>!
    let toDoFetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutMenuButtons()
        layoutToDoTable()
        
        checkOnLaunch()
        attemptToDoFetch()
        attemptCategoryFetch()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        attemptToDoFetch()
        toDoTable.reloadData()
        
    }
    
    func checkOnLaunch() {
        
        let defaults = UserDefaults.standard
        let hasRan = defaults.bool(forKey: "hasRan")
        Shared.isPremium = defaults.bool(forKey: "isPremium")
        
        if !hasRan {
            
            generateStartingData()
            defaults.set(true, forKey: "hasRan")
            
        }
    }
    
    @objc func settingsPressed(sender: UIButton!) {
        
        performSegue(withIdentifier: "showSettings", sender: nil)
        
    }
    
    @objc func addPressed(sender: UIButton!) {
        
        performSegue(withIdentifier: "addEditToDo", sender: nil)
        
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
            
            cell.clearCell()
            cell.configureCell(toDo: objects[indexPath.row])
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        toDoTable.deselectRow(at: indexPath, animated: true)
        
        if let objects = toDoController.fetchedObjects, objects.count > 0 {
            
            let object = objects[indexPath.row]
            performSegue(withIdentifier: "addEditToDo", sender: object)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addEditToDo" {
            
            if let destination = segue.destination as? AddToDoVC {
                
                if let toDoToEdit = sender as? ToDo {
                    
                    destination.toDoToEdit = toDoToEdit
                    
                }
            }
        } else if segue.identifier == "showSettings" {
            
            if let destination = segue.destination as? SettingsVC {
                
                destination.modalPresentationStyle = .overFullScreen
                
            }
        }
    }
}

