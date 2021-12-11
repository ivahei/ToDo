//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Vahe Abazyan on 09.12.21.
//

import UIKit

// MARK: - ToDoTableViewController

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem

        todos = ToDo.loadToDos() ?? ToDo.loadSumpleToDos()
    }

    @IBAction func unwindToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as? NewToDoTableViewController

        if let todo = sourceViewController?.todo {
            if let indexOfExistingToDo = todos.firstIndex(of: todo) {
                todos[indexOfExistingToDo] = todo
                tableView.insertRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> NewToDoTableViewController? {
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell)
        else { return nil }

        tableView.deselectRow(at: indexPath, animated: true)

        let editVC = NewToDoTableViewController(coder: coder)
        editVC?.todo = todos[indexPath.row]

        return editVC
    }
}

extension ToDoTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier",
                                                 for: indexPath) as! ToDoTableViewCell
        cell.toDoTitle.text = todos[indexPath.row].title
        cell.isCompleteButton.isSelected = todos[indexPath.row].isComplete

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath)
        -> Bool { true }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
