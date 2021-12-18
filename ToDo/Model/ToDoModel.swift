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

    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    static func loadToDos() -> [ToDo]? {
        return nil
    }

    static func loadSumpleToDos() -> [ToDo] {
        [
            ToDo(title: "Eat", isComplete: true, dueDate: Date(), notes: "I am hungry"),
            ToDo(title: "Swim", isComplete: false, dueDate: Date(), notes: "I am dirty"),
            ToDo(title: "Brush my teeth", isComplete: false, dueDate: Date(), notes: "My breath smells bad")
        ]
    }

    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}
