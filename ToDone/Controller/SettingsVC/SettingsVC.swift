//
//  SettingsVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/9/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK: UI Variables
    let settingsView = UIView()
    let categoryTable = UITableView()
    
    var tapGesture = UITapGestureRecognizer()
    
    var selectedCategory: Category?
    
    //MARK: CoreData Variables
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
    
    //MARK: StoreKit Variables
    let network = NetworkIndicator()
    let defaults = UserDefaults.standard

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
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
                
                performSegue(withIdentifier: "unwindToLeft", sender: nil)
                
            }
        }
    }
    
    //MARK: Setup for categoryTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfCategories = 0
        
        if let objects = categoryController.fetchedObjects, objects.count > 0 {
            
            numOfCategories = objects.count
            
        }
        
        switch Shared.isPremium {
        case true: numOfCategories += 1
        case false: numOfCategories += 2
        }
        
        return numOfCategories
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryCell
        
        cell.backgroundColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1)
        
        if indexPath.row == 0 {
            
            switch Shared.isPremium {
            case true: cell.configureAddCell()
            case false: cell.configurePurchaseCell()
            }
            
        } else if indexPath.row == 1 {
        
            switch Shared.isPremium {
            case true:
                if let objects = categoryController.fetchedObjects, objects.count > 0 {
                    
                    cell.clearCell()
                    cell.configureCell(category: objects[indexPath.row - 1])
                    
                }
            case false: cell.configureAddCell()
            }
            
        } else {
            
            if let objects = categoryController.fetchedObjects, objects.count > 0 {
                
                switch Shared.isPremium {
                case true:
                    cell.clearCell()
                    cell.configureCell(category: objects[indexPath.row - 1])
                case false:
                    cell.clearCell()
                    cell.configureCell(category: objects[indexPath.row - 2])
                }
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let objects = categoryController.fetchedObjects else { return }
        
        if indexPath.row == 0 {
            
            switch Shared.isPremium {
            case true: performSegue(withIdentifier: "addCategory", sender: nil)
            case false: buyProduct(productID: Products.premium.rawValue)
            }
            
        } else if indexPath.row == 1 {
            
            switch Shared.isPremium {
            case true:
                Shared.selectedCategory = objects[indexPath.row - 1]
                performSegue(withIdentifier: "unwindToLeft", sender: nil)
            case false:
                
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
                 
                    performSegue(withIdentifier: "addCategory", sender: nil)
                    
                }
            }
            
        } else {
            
            Shared.selectedCategory = objects[indexPath.row - 2]
            performSegue(withIdentifier: "unwindToLeft", sender: nil)
            
        }
        
        categoryTable.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var cellActions = [UITableViewRowAction]()
        var beginningIndex = 0
        
        switch Shared.isPremium {
        case true: beginningIndex = 1
        case false: beginningIndex = 2
        }
        
        if indexPath.row >= beginningIndex {
            
            let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, index in
                
                guard let objects = self.categoryController.fetchedObjects else { return }
                
                let object = objects[indexPath.row - beginningIndex]
                context.delete(object)
                ad.saveContext()
                
                self.attemptCategoryFetch()
                self.categoryTable.deleteRows(at: [indexPath], with: .automatic)
                
            })
            
            cellActions = [delete]
            
        }
        
        return cellActions
        
    }
}
