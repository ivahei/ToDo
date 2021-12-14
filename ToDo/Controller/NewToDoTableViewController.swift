//
//  NewToDoTableViewController.swift
//  ToDo
//
//  Created by Vahe Abazyan on 11.12.21.
//

import UIKit

class NewToDoTableViewController: UITableViewController {
    
    @IBOutlet private var remindMeTextFieldMark: UIImageView!
    @IBOutlet private var remindMeTextFieldOutlet: UITextField!
    @IBOutlet private var saveButtonOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonOutlet.isEnabled = false
    }
    
    @IBAction func remindMeTextFieldEditingChanged(_ sender: Any) {
        ckeckRemindMeTextField()
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
}
