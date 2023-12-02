//
//  ContentView.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//


import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var task: TaskModel?
    @State private var currentDate: Date = .init()
    @State private var createNewTask: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0, content: {
            HeaderView()
            ScrollView(.vertical) {
                TaskView()
            }
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
            AddNewTaskView()
                .presentationDetents([.height(450)])
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
}
