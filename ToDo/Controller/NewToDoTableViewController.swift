//
//  NewToDoTableViewController.swift
//  ToDo
//
//  Created by Vahe Abazyan on 11.12.21.
//

import UIKit

class NewToDoTableViewController: UITableViewController {
    
    var isDatePickerHiden = true
    let dueDateIndexPath = IndexPath(row: 0, section: 1)
    let dueDatePickerIndexPath = IndexPath(row: 1, section: 1)

    
    @IBOutlet private var remindMeTextFieldMark: UIImageView!
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
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDate(sender.date)
    }
    
    func ckeckRemindMeTextField() {
        if remindMeTextFieldOutlet.text!.isEmpty {
            remindMeTextFieldMark.image = UIImage(systemName: "circlebadge")
            saveButtonOutlet.isEnabled = false
        } else {
            remindMeTextFieldMark.image = UIImage(systemName: "checkmark.circle.fill")
            saveButtonOutlet.isEnabled = true
        }
    }
    
    func updateDueDate(_ date: Date) {
        dueDate.text = ToDo.dueDateFormatter.string(from: date)
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
