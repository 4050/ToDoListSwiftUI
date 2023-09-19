//
//  ContentView.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//


import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [Task] = [
        Task(title: "Задача 1", taskDescription: "", dueDate: Date.init(),  isCompleted: false, color: .blue.opacity(0.5)),
        Task(title: "Задача 2", taskDescription: "", dueDate: Date().addingTimeInterval(86400),  isCompleted: false, color: .red.opacity(0.5)),
        Task(title: "Задача 3", taskDescription: "", dueDate: Date().addingTimeInterval(172800), isCompleted: false, color: .green.opacity(0.5)),
        Task(title: "Задача 4", taskDescription: "", dueDate: Date().addingTimeInterval(259200),  isCompleted: false, color: .yellow.opacity(0.5))
    ]
    
    @State private var taskFromTaskView: Task?
    
    @State private var currentDate: Date = .init()
    @State private var createNewTask: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HeaderView()
            ScrollView(.vertical) {
                TaskView()
            }
            .hSpacing(.center)
            .vSpacing(.center)
            .scrollIndicators(.hidden)
        })
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWidth(.standard)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(.blue)
                    .cornerRadius(30)
            })
            .padding(20)
        })
        .sheet(isPresented: $createNewTask, content: {
            AddNewTaskView(addTodo: {
                newTask in
                tasks.append(newTask)
            })
            .presentationDetents([.height(350)])
            .interactiveDismissDisabled()
            .presentationCornerRadius(30)
        })
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.blue)
                
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            Text(currentDate.formatted(date: .abbreviated, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
        }
        .padding(15)
        .hSpacing(.leading)
        .background(.white)
    }
    
    @ViewBuilder
    func TaskView() -> some View {
        let today = Calendar.current.startOfDay(for: currentDate)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let future = Calendar.current.date(byAdding: .day, value: 2, to: today)!
        
        VStack(alignment: .leading, spacing: 15) {
            Section(header: Text("Сегодня").font(.title).bold()) {
                ForEach($tasks) { $task in
                    if Calendar.current.isDate(task.dueDate, inSameDayAs: today) {
                        TaskRowView(task: $task)
                    }
                }
            }
            
            Section(header: Text("Завтра").font(.title).bold()) {
                ForEach($tasks) { $task in
                    if Calendar.current.isDate(task.dueDate, inSameDayAs: tomorrow) {
                        TaskRowView(task: $task)
                    }
                }
            }
            
            Section(header: Text("Будущее").font(.title).bold()) {
                ForEach($tasks) { $task in
                    if task.dueDate > future {
                        TaskRowView(task: $task)
                    }
                }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 5)
    }
}

#Preview {
    ContentView()
}

