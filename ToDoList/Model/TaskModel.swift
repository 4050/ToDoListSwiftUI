//
//  TaskModel.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var dueDate: Date?
    var isCompleted: Bool = false
}
