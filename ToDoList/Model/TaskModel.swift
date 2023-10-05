//
//  TaskModel.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class TaskModel: Identifiable {
    var id: UUID
    var title: String
    var taskDescription: String
    var dueDate: Date
    var creationDate: Date
    var isCompleted: Bool = false
    var color: String
    
    init(var id: UUID = .init(), title: String, taskDescription: String, dueDate: Date, creationDate: Date, isCompleted: Bool, color: String) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.color = color
    }
}

extension TaskModel {
    var tintColor: Color {
        switch color {
        case "TaskColor1": return .blue
        case "TaskColor2": return .red
        case "TaskColor3": return .green
        case "TaskColor4": return .yellow
        default: return .black
        }
    }
}
