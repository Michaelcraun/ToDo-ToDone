//
//  AddToDoVC.swift
//  ToDone
//
//  Created by Michael Craun on 10/7/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData

class AddToDoVC: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
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
    var deadline = Date()
    var dateString = ""
    
    //MARK: CoreData Variables
    var categoryController: NSFetchedResultsController<Category>!
    let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
    var subToDoController: NSFetchedResultsController<SubToDo>!
    let subToDoFetchRequest: NSFetchRequest<SubToDo> = SubToDo.fetchRequest()
    var categories = [Category]()
    var selectedCateogry = Category()
    var toDoToEdit: ToDo?
    var subToDoToEdit = [SubToDo]()

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
        
        if toDoToEdit != nil {
            
            newToDo = toDoToEdit
            
        } else {
            
            newToDo = ToDo(context: context)
        }
        
        if titleInput.text != "" {
            
            let totalSubToDos = Double(subToDoToEdit.count)
            var subToDosCompleted: Double = 0
            
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
            
            let percentageComplete = (subToDosCompleted / totalSubToDos) * 100
            let intCompleted = Int(percentageComplete)
            newToDo.completed = Int16(intCompleted)
            
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
            
            cell.configureCell(subToDo: subToDoToEdit[indexPath.row - 1])
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        subToDoTable.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let transition = "addSubToDo"
            
            performSegue(withIdentifier: "addDetails", sender: transition)
            
        } else {
            
            switch subToDoToEdit[indexPath.row - 1].completed {
            case true: subToDoToEdit[indexPath.row - 1].completed = false
            case false: subToDoToEdit[indexPath.row - 1].completed = true
            }
            
            subToDoTable.reloadData()
            
        }
    }
}
