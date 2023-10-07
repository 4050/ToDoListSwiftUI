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
        VStack(alignment: .leading, spacing: 15) {
            let todayTasks = tasksQuery.filter { task in
                task.dueDate == CurrentDate.today()
            }
            ForEach(todayTasks) { task in
                TaskRowView(task: task)
            }
            if todayTasks.isEmpty {
                Text("Нет задач")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Section(header: Text("Завтра").font(.title).bold()) {
                let tomorrowTasks = tasksQuery.filter { task in
                    task.dueDate == CurrentDate.tomorrow()
                }
                ForEach(tomorrowTasks) { task in
                    TaskRowView(task: task)
                }
                if tomorrowTasks.isEmpty {
                    Text("Нет задач")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Будущее").font(.title).bold()) {
                let futureTasks = tasksQuery.filter { task in
                    task.dueDate > CurrentDate.tomorrow()
                }
                ForEach(futureTasks) { task in
                    TaskRowView(task: task)
                }
                if futureTasks.isEmpty {
                    Text("Нет задач")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Не выполненные").font(.title).bold()) {
                let overdueTasks = tasksQuery.filter { task in
                    task.dueDate < CurrentDate.today()
                }
                ForEach(overdueTasks) { task in
                    TaskRowView(task: task)
                }
                if overdueTasks.isEmpty {
                    Text("Нет задач")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 5)
    }
}
