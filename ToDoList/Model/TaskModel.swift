//
//  TaskModel.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var taskDescription: String
    var dueDate: Date
    var creationDate: Date = .init()
    var isCompleted: Bool = false
    var color: Color
}
