//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: TaskModel.self)
        }
    }
}
