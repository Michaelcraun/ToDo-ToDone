//
//  AddToDoVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData
import StoreKit

class AddToDoVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    //MARK: New ToDo Form Variables
    let cancelButton = TextButton()
    let doneButton = TextButton()
    let titleInput = InputField()
    let deadlineInput = InputField()
    let categoryButton = UIButton()
    let categoryView = CategoryView()
    let categoryLabel = UILabel()
    let subToDoTable = UITableView()
    
    let pickerView = UIView()
    let deadlinePicker = UIDatePicker()
    var deadline: Date?
    var dateString = ""
    
    //MARK: CoreData Variables
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
    var subToDoController: NSFetchedResultsController<SubToDo>!
    let subToDoFetchRequest: NSFetchRequest<SubToDo> = SubToDo.fetchRequest()
    var categories = [Category]()
    var selectedCateogry: Category?
    var toDoToEdit: ToDo?
    var subToDoToEdit = [SubToDo]()
    
    //MARK: StoreKit Variables
    let network = NetworkIndicator()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptCategoryFetch()
        attemptSubToDoFetch()
        
        layoutSystemButtons()
        layoutTitleInput()
        layoutDeadlineInput()
        layoutCategoryButton()
        layoutSubToDoTable()
        
        if toDoToEdit != nil {
            
            loadData()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Shared.selectedCategory != nil {
            
            selectedCateogry = Shared.selectedCategory!
            
            categoryView.backgroundColor = Shared.selectedCategory?.color as? UIColor
            categoryLabel.text = Shared.selectedCategory?.title
            
            Shared.selectedCategory = nil
            
        }
        
        if Shared.createdSubToDo != nil {
            
            subToDoToEdit.append(Shared.createdSubToDo!)
            subToDoTable.reloadData()
            
            Shared.createdSubToDo = nil
            
        }
    }
    
    @objc func cancelPressed(sender: UIButton!) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func donePressed(sender: UIButton!) {
        
        var newToDo: ToDo!
        var percentageComplete = 0.0
        
        if toDoToEdit != nil {
            
            newToDo = toDoToEdit
            
        } else {
            
            newToDo = ToDo(context: context)
        }
        
        if titleInput.text != "" {
            
            let totalSubToDos = subToDoToEdit.count
            var subToDosCompleted = 0.0
            
            newToDo.title = titleInput.text!
            newToDo.dateAdded = Date()
            newToDo.deadline = deadline
            newToDo.category = selectedCateogry
            newToDo.subToDo = nil
            
            for subToDo in subToDoToEdit {
                
                newToDo.addToSubToDo(subToDo)
                
                if subToDo.completed {
                    
                    subToDosCompleted += 1
                    
                }
            }
            
            if totalSubToDos != 0 {
                
                percentageComplete = (subToDosCompleted / Double(totalSubToDos)) * 100
                
            }
            
            let intCompleted = Int(percentageComplete)
            newToDo.completed = Int16(intCompleted)
            
            if deadline == nil {
                
                let reminderDate = Date().addingTimeInterval(86400)
                ad.scheduleRecurringReminder(at: reminderDate, withToDo: newToDo)
                
            } else {
                
                //            let reminderDate = deadline.addingTimeInterval(60)
                let reminderDate = deadline!.addingTimeInterval(-86400)
                ad.scheduleNotification(at: reminderDate, withToDo: newToDo)
                
            }
            
            ad.saveContext()
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Missing Title", message: "Your ToDo is missing a title.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    @objc func donePicker(sender: UIBarButtonItem!) {
        
        if sender.title == "Done" {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM DD, YY"
            dateFormatter.dateStyle = .long
            
            dateString = dateFormatter.string(from: deadlinePicker.date)
            
            deadline = deadlinePicker.date
            deadlineInput.text = dateString
            deadlineInput.resignFirstResponder()
            
        } else {
            
            pickerView.removeFromSuperview()
            deadlineInput.resignFirstResponder()
            
        }
    }
    
    @objc func checkPicker(sender: UIDatePicker!) {
        
        let currentDate = Date()
        
        if sender.date < currentDate {
            
            sender.setDate(currentDate, animated: true)
            
        }
    }
    
    @objc func selectCategory(sender: UIButton!) {
        
        let transition = "addCategory"
        
        performSegue(withIdentifier: "addDetails", sender: transition)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addDetails" {
            
            if let destination = segue.destination as? AddDetailsVC {
            
                if let transition = sender as? String {
                    
                    destination.transition = transition
                    
                }
            }
        }
    }
    
    //MARK: Setup subToDoTable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subToDoToEdit.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subToDoCell") as! SubToDoCell
        
        if indexPath.row == 0 {
            
            cell.configureAddCell()
            
        } else {
            
            cell.clearCell()
            cell.configureCell(subToDo: subToDoToEdit[indexPath.row - 1])
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        subToDoTable.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let transition = "addSubToDo"
            
            if Shared.isPremium {
                
                performSegue(withIdentifier: "addDetails", sender: transition)
                
            } else {
                
                if subToDoToEdit.count >= 5 {
                    
                    let alert = UIAlertController(title: "Premium Required", message: """
                    To create more than 5 ToDo's, you must purchase ToDo Premium.

                    Do you wish to purchase?
                    """, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                        
                        self.buyProduct(productID: Products.premium.rawValue)
                        
                    }))
                    
                    present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    performSegue(withIdentifier: "addDetails", sender: transition)
                    
                }
            }
            
        } else {
            
            switch subToDoToEdit[indexPath.row - 1].completed {
            case true: subToDoToEdit[indexPath.row - 1].completed = false
            case false: subToDoToEdit[indexPath.row - 1].completed = true
            }
            
            subToDoTable.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var cellActions = [UITableViewRowAction]()
        
        if indexPath.row >= 1 {
         
            let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, index in
                
                print(self.subToDoToEdit[indexPath.row - 1])
                self.subToDoToEdit.remove(at: indexPath.row - 1)
                self.subToDoTable.deleteRows(at: [indexPath], with: .automatic)
                
            })
            
            cellActions = [delete]
            
        }
        
        return cellActions
        
    }
}
