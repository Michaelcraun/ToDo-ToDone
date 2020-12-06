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

class AddToDoVC: UIViewController, Alertable, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
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
    var toDoToSave: ToDo?
    
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
        
        if Shared.instance.selectedCategory != nil {
            
            selectedCateogry = Shared.instance.selectedCategory!
            
            categoryView.backgroundColor = Shared.instance.selectedCategory?.color as? UIColor
            categoryLabel.text = Shared.instance.selectedCategory?.title
            
            Shared.instance.selectedCategory = nil
            
        }
        
        if Shared.instance.createdSubToDo != nil {
            
            subToDoToEdit.append(Shared.instance.createdSubToDo!)
            subToDoTable.reloadData()
            
            Shared.instance.createdSubToDo = nil
            
        }
    }
    
    @objc func cancelPressed(sender: UIButton!) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func donePressed(sender: UIButton!) {
        var percentageComplete = 0.0
        
        if toDoToEdit != nil {
            toDoToSave = toDoToEdit
        } else {
            toDoToSave = ToDo(context: context)
        }
        
        if titleInput.text != "" {
            
            let totalSubToDos = subToDoToEdit.count
            var subToDosCompleted = 0.0
            
            toDoToSave?.title = titleInput.text!
            toDoToSave?.dateAdded = Date()
            toDoToSave?.deadline = deadline
            toDoToSave?.category = selectedCateogry
            toDoToSave?.subToDo = nil
            
            for subToDo in subToDoToEdit {
                toDoToSave?.addToSubToDo(subToDo)
                if subToDo.completed {
                    subToDosCompleted += 1
                }
            }
            
            if totalSubToDos != 0 { percentageComplete = (subToDosCompleted / Double(totalSubToDos)) * 100 }
            
            let intCompleted = Int(percentageComplete)
            toDoToSave?.completed = Int16(intCompleted)
            
            if deadline == nil {
                showAlert(.recurringReminder)
            } else {
                scheduleReminder(recurring: false)
            }
        } else {
            showAlert(.missingTitle)
        }
    }
    
    func scheduleReminder(recurring: Bool) {
        if recurring {
            let reminderDate = Date().addingTimeInterval(86400)
            ad.scheduleRecurringReminder(at: reminderDate, withToDo: toDoToSave!)
            ad.saveContext()
        } else {
            let reminderDate = deadline!.addingTimeInterval(-86400)
            ad.scheduleNotification(at: reminderDate, withToDo: toDoToSave!)
            ad.saveContext()
        }
        dismiss(animated: true, completion: nil)
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
        if indexPath.row == 0 {
            let transition = "addSubToDo"
            
            if Shared.instance.isPremium {
                performSegue(withIdentifier: "addDetails", sender: transition)
            } else {
                if subToDoToEdit.count >= 5 {
                    showAlert(.premiumRequired)
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
        
        subToDoTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete", handler: { action, index in
            
            self.subToDoToEdit.remove(at: indexPath.row - 1)
            self.subToDoTable.deleteRows(at: [indexPath], with: .automatic)
        })
        
        if indexPath.row > 0 { return [delete] }
        
        return []
    }
}
