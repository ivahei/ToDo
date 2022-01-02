//
//  NewToDoTableViewController.swift
//  ToDo
//
//  Created by Vahe Abazyan on 11.12.21.
//

import UIKit

class NewToDoTableViewController: UITableViewController {
    
    var todo: ToDo?
    var isSelected = false
    var isDatePickerHidden = true
    let dueDateIndexPath = IndexPath(row: 0, section: 1)
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 1)

    @IBOutlet private var isComplete: UIButton!
    @IBOutlet private var remindMeTextFieldOutlet: UITextField!
    @IBOutlet private var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet private var dueDate: UILabel!
    @IBOutlet private var dueDatePickerView: UIDatePicker!
    @IBOutlet private var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            remindMeTextFieldOutlet.text = todo.title
            isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            saveButtonOutlet.isEnabled = false
            dueDatePickerView.date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        }
        setIsSelectedImage()
        updateDueDate(dueDatePickerView.date)
    }
    
    @IBAction func remindMeTextFieldEditingChanged(_ sender: Any) {
        checkRemindMeTextField()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDate(sender.date)
    }
    
    func checkRemindMeTextField() {
        if remindMeTextFieldOutlet.text!.isEmpty {
            saveButtonOutlet.isEnabled = false
        } else {
            saveButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isSelected.toggle()
        setIsSelectedImage()
    }

    func setIsSelectedImage() {
        let image = isSelected ?
        UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circlebadge")
        isComplete.setImage(image, for: .normal)
    }

    func updateDueDate(_ date: Date) {
        dueDate.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind",
              let title = remindMeTextFieldOutlet.text
        else { return }

        let isComplete = isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(id: todo?.id ?? UUID().uuidString,
                    title: title,
                    isComplete: isComplete,
                    dueDate: dueDate,
                    notes: notes)
    }
}

extension NewToDoTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == dueDatePickerIndexPath && isDatePickerHidden {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if indexPath == dueDateIndexPath {
            isDatePickerHidden.toggle()
            updateDueDate(dueDatePickerView.date)
            tableView.reloadData()
        }
    }
}
