//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Vahe Abazyan on 09.12.21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        todos = ToDo.loadToDos() ?? ToDo.loadSumpleToDos()
    }
    
    @IBAction func unwindToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! NewToDoTableViewController
        
        if let todo = sourceViewController.todo {
            let newIndexPath = IndexPath(row: todos.count, section: 0)
            
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}

extension ToDoTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier",
                                                 for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title

        return cell
    }

    override func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
