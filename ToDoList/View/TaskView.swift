//
//  TaskView.swift
//  ToDoList
//
//  Created by Станислав on 03.10.2023.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    
    @State private var currentDate: Date = .init()
    @Query private var tasksQuery: [TaskModel]
    
    var body: some View {
        let today = Calendar.current.startOfDay(for: currentDate)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let future = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        
        VStack(alignment: .leading, spacing: 15) {
            ForEach(tasksQuery) { task in
                if Calendar.current.isDate(task.dueDate, inSameDayAs: today) {
                    TaskRowView(task: task)
                }
            }
            
            Section(header: Text("Завтра").font(.title).bold()) {
                ForEach(tasksQuery) { task in
                    if Calendar.current.isDate(task.dueDate, inSameDayAs: tomorrow) {
                        TaskRowView(task: task)
                    }
                }
            }
            
            Section(header: Text("Будущее").font(.title).bold()) {
                ForEach(tasksQuery) { task in
                    if Calendar.current.isDate(task.dueDate, inSameDayAs: future) {
                        TaskRowView(task: task)
                    }
                }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 5)
    }
}


