//
//  ToDoTableViewCell.swift
//  ToDo
//
//  Created by Vahe Abazyan on 11.12.21.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var toDoTitle: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        
    }
}
