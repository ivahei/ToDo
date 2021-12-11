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
    var isDatePickerHiden = true
    let dueDateIndexPath = IndexPath(row: 0, section: 1)
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 1)

    
    @IBOutlet private var isComplite: UIButton!
    @IBOutlet private var remindMeTextFieldOutlet: UITextField!
    @IBOutlet private var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet private var dueDate: UILabel!
    @IBOutlet private var dueDatePickerView: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonOutlet.isEnabled = false
        dueDatePickerView.date = Date().addingTimeInterval(1*60*60)
        updateDueDate(dueDatePickerView.date)
    }
    
    @IBAction func remindMeTextFieldEditingChanged(_ sender: Any) {
        ckeckRemindMeTextField()
    }
    
    // uzum em es text field@ edit skseluc yete bac lini date picker@ paki bayc xndir ka reloadic heto editing@ kangnum a.
    // nuyn@ notes-i mej kanei yete ashxater
    @IBAction func remindMeTextFieldEditingDidBegin(_ sender: Any) {
        if !isDatePickerHiden {
            isDatePickerHiden = true
            tableView.reloadData()
        }
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDate(sender.date)
    }
    
    func ckeckRemindMeTextField() {
        if remindMeTextFieldOutlet.text!.isEmpty {
            saveButtonOutlet.isEnabled = false
        } else {
            saveButtonOutlet.isEnabled = true
        }
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        if isSelected {
            isSelected.toggle()
            isComplite.setImage(UIImage(systemName: "circlebadge"), for: .normal)
        } else {
            isSelected.toggle()
            isComplite.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }
    
    
    func updateDueDate(_ date: Date) {
        dueDate.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = remindMeTextFieldOutlet.text!
        let isComplete = isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
}

extension NewToDoTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == dueDatePickerIndexPath && isDatePickerHiden {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if indexPath == dueDateIndexPath {
            isDatePickerHiden.toggle()
            updateDueDate(dueDatePickerView.date)
            tableView.reloadData()
        }
    }
}