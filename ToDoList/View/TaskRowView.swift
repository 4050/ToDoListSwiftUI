//
//  TaskRowView.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: TaskModel
    @Environment(\.modelContext) var contex
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: task .isCompleted ? "smallcircle.circle.fill": "circle")
                .foregroundColor(task.tintColor)
                .opacity(0.7)
            .onTapGesture {
                    task.isCompleted.toggle()
                    print("task isCompleted")
            }
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(task.title)
                    .fontWeight(.semibold)
                //Label(task.dueDate.format("dd MMM HH:mm "), systemImage: "")
                //    .font(.caption)
                 //   .environment(\.locale, Locale(identifier: "en_GB"))
            })
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
            .contentShape(.contextMenuPreview, .rect(topLeadingRadius: 15, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 15))
            .contextMenu(menuItems: {
                Button("Delete task", role: .destructive, action: {
                    contex.delete(task)
                    try? contex.save()
                })
            })
            .offset(y: -8)
        } 
    }
}
