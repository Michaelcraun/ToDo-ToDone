//
//  ViewController.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class MainVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK: UI Variables
    let settingsButton = UIButton()
    let addButton = UIButton()
    let toDoTable = UITableView()
    @IBAction func unwindToMain(segue: UIStoryboardSegue) { }
    
    //MARK: CoreData Variables
    var toDoController: NSFetchedResultsController<ToDo>!
    let toDoFetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    var selectedCategory: Category?
    
    //MARK: StoreKit Variables
    let network = NetworkIndicator()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutMenuButtons()
        layoutToDoTable()
        
        checkOnLaunch()
        attemptToDoFetch()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        attemptToDoFetch()
        toDoTable.reloadData()
        
    }
    
    func checkOnLaunch() {
        
        let hasRan = defaults.bool(forKey: "hasRan")
        checkPurchases()
        
        if !hasRan {
            
            generateStartingData()
            defaults.set(true, forKey: "hasRan")
            
        }
        
        if !Shared.isPremium {
            
            checkCanMakePayments()
            
        }
    }
    
    @objc func settingsPressed(sender: UIButton!) {
        
        performSegue(withIdentifier: "showSettings", sender: nil)
        
    }
    
    @objc func addPressed(sender: UIButton!) {
        
        if Shared.isPremium {
            
            performSegue(withIdentifier: "addEditToDo", sender: nil)
            
        } else {
            
            guard let objects = toDoController.fetchedObjects else { return }
            
            if objects.count >= 5 {
                
                let alert = UIAlertController(title: "Premium Required", message: """
                    To create more than 5 ToDo's, you must purchase ToDo ToDone Premium.
                    Do you wish to purchase?
                    """, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    
                    self.buyProduct(productID: Products.premium.rawValue)
                    
                }))
                
                present(alert, animated: true, completion: nil)
                
            } else {
                
                performSegue(withIdentifier: "addEditToDo", sender: nil)
                
            }
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
                
                destination.modalPresentationStyle = .overCurrentContext
                
            }
        }
    }
    
    //MARK: Handles toDoTable setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        var numOfToDos = 0
        
        guard let objects = toDoController.fetchedObjects else { return 0 }
        
//            if categoryToSortBy == nil {
            
//                numOfToDos = objects.count
        
//            } else {
//
//                let categoryToCompare = categoryToSortBy!
//
//                for object in objects {
//
//                    switch object.category! {
//                    case categoryToCompare: numOfToDos += 1
//                    default: break
//                    }
//                }
//            }
        
        return objects.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoCell
        
        if let objects = toDoController.fetchedObjects, objects.count > 0 {
            
//            if categoryToSortBy == nil {
            
                cell.clearCell()
                cell.configureCell(toDo: objects[indexPath.row])
                
//            } else {
//
//                let categoryToCompare = categoryToSortBy!
//
//                for object in objects {
//
//                    switch object.category! {
//                    case categoryToCompare: cell.configureCell(toDo: object)
//                    default: break
//                    }
//                }
//            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        toDoTable.deselectRow(at: indexPath, animated: true)
        
        guard let objects = toDoController.fetchedObjects else { return }
        let object = objects[indexPath.row]
        
        performSegue(withIdentifier: "addEditToDo", sender: object)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { action, index in
            
            if let objects = self.toDoController.fetchedObjects, objects.count > 0 {
                
                let object = objects[indexPath.row]
                ad.removeNotification(withToDo: object)
                context.delete(object)
                ad.saveContext()
                
                self.attemptToDoFetch()
                self.toDoTable.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
        return [delete]
        
    }
}

