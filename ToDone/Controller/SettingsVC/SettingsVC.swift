//
//  SettingsVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate {
    
    let settingsView = UIView()
    let categoryTable = UITableView()
    
    var tapGesture = UITapGestureRecognizer()
    
    //MARK: CoreData Variables
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptCategoryFetch()

        layoutCategoryTable()
        addGestureRecognizer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        attemptCategoryFetch()
        categoryTable.reloadData()
        
    }
    
    func addGestureRecognizer() {
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsVC.dismissView(sender:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    //MARK: Dismiss view when you tap outside of pane.
    @objc func dismissView(sender: UITapGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.ended {
            
            if !categoryTable.bounds.contains(sender.location(in: categoryTable)) {
                
                let destination = MainVC()
                let segue = UnwindSlideFromLeft(identifier: "unwindToLeft", source: self, destination: destination)
                segue.perform()
                
            }
        }
    }
    
    //MARK: Setup for categoryTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfCategories = 0
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
            
            numOfCategories = objects.count
            
        }
        
        return numOfCategories + 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        cell.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1)
        
        if indexPath.row == 0 {
            
            cell.configurePurchaseCell()
            
        } else if indexPath.row == 1 {
        
            cell.configureAddCell()
            
        } else {
            
            if let objects = categoryController.fetchedObjects, objects.count > 0 {
                
                cell.configureCell(category: objects[indexPath.row - 2])
                
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            
        } else if indexPath.row == 1 {
            
            performSegue(withIdentifier: "addCategory", sender: nil)
            
        } else {
            
            
        }
        
        categoryTable.deselectRow(at: indexPath, animated: true)
        
    }
}
