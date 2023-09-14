//
//  TaskRowView.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import SwiftUI

struct TaskRowView: View {
    @Binding var task: Task
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: task .isCompleted ? "smallcircle.circle.fill": "circle")
                .foregroundColor(task.color)
            .onTapGesture {
                    task.isCompleted.toggle()
                    print("task isCompleted")
            }
            VStack(alignment: .leading, spacing: 8, content: {
                Text(task.title)
                    .fontWeight(.semibold)
                Label(task.dueDate.format("dd MMM HH:mm "), systemImage: "clock")
                    .font(.caption)
                    .environment(\.locale, Locale(identifier: "en_GB"))
            })
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
        }
    }
}
