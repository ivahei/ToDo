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
        
        todos = ToDo.loadToDos() ?? ToDo.loadSumpleToDos()
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier",
                                                 for: indexPath)
        cell.textLabel?.text = todos[indexPath.row].title

        return cell
    }
}
