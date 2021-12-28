//
//  ToDoModel.swift
//  ToDo
//
//  Created by Vahe Abazyan on 09.12.21.
//

import Foundation

struct ToDo: Equatable {
    let id: String
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

    static func loadSampleToDos() -> [ToDo] {
        [
            ToDo(id: UUID().uuidString, title: "Eat", isComplete: true, dueDate: Date(), notes: "I am hungry"),
            ToDo(id: UUID().uuidString, title: "Swim", isComplete: false, dueDate: Date(), notes: "I am dirty"),
            ToDo(id: UUID().uuidString, title: "Brush my teeth", isComplete: false, dueDate: Date(), notes: "My breath smells bad")
        ]
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
