//
//  NewTaskRowView.swift
//  ToDoList
//
//  Created by Станислав on 10.10.2023.
//

import Foundation
import SwiftUI

struct NewTaskRowView: View {
    @Bindable var task: TaskModel
    @Environment(\.modelContext) var contex
    @State private var isShowingTaskDetail = false
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Button(action: {
            }) {
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(task.color))
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(Color(task.color))
                }
            }
            .onTapGesture {
                toggleTaskCompletion()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(task.title)
                    .font(.system(size: 20, weight: .semibold))
                Label(task.dueDate.format("dd MMM HH:mm"), systemImage: "")
                    .font(.callout)
                    .environment(\.locale, Locale(identifier: "en_GB"))
            }
        }
        // .frame(maxWidth: .infinity)
        // .padding()
        // .background(Color(task.color).opacity(0.2))
        // .clipShape(.rect(cornerRadius: 20))
        
        //.padding(.horizontal)
        .strikethrough(task.isCompleted, pattern: .solid, color: .black)
        //.contentShape(.contextMenuPreview, .rect(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 15))
        .contextMenu(menuItems: {
            Button("Delete task", role: .destructive, action: {
                contex.delete(task)
                try? contex.save()
            })
            Button("Edit task", role: .destructive, action: {
                isShowingTaskDetail.toggle()
            })
        })
        .sheet(isPresented: $isShowingTaskDetail, content: {
            DetailTaskView(task: task)
                .presentationDetents([.height(450)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
        })
        .background(Color(task.color).opacity(0.0))
        .swipeActions {
            Button(action: {
                contex.delete(task)
                try? contex.save()
            }) {
                Image(systemName: "trash.circle")
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading) {
            if task.isCompleted {
                Button(action: {
                    task.isCompleted = false
                }) {
                    Image(systemName: "x.circle")
                }
                .tint(.blue)
            } else {
                Button(action: {
                    task.isCompleted = true
                }) {
                    Image(systemName: "checkmark.circle")
                }
                .tint(.green)
            }
        }
    }
    
    private func toggleTaskCompletion() {
        task.isCompleted.toggle()
        try? contex.save()
    }
}

