//
//  ToDoModel.swift
//  ToDo
//
//  Created by Vahe Abazyan on 09.12.21.
//

import Foundation


struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSumpleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "Eat", isComplete: true, dueDate: Date(), notes: "I am hungry")
        let toDo2 = ToDo(title: "Swim", isComplete: false, dueDate: Date(), notes: "I am dirty")
        let toDo3 = ToDo(title: "Brush my teeth", isComplete: false, dueDate: Date(), notes: "My breath smells bad")
        return [toDo1, toDo2, toDo3]
    }
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}
