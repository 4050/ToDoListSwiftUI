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
    @State private var isShowingTaskEdit = false
    @State private var isShowingTaskDetail = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 5) {
                // Button in its own VStack
                VStack {
                    Button(action: {
                        toggleTaskCompletion()
                    }) {
                        if task.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(task.color))
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(Color(task.color))
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                }
                
                // Other content in the HStack
                SwipeAction(cornerRadius: 15, direction: .trailing, shape: .cicle) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(task.title)
                            .font(.system(size: 20, weight: .semibold))
                        Label(task.dueDate.format("dd MMM HH:mm"), systemImage: "clock")
                            .font(.callout)
                            .environment(\.locale, Locale(identifier: "en_GB"))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(10)
                    .contentShape(.contextMenuPreview, .rect(topLeadingRadius: 10, bottomLeadingRadius: 10, bottomTrailingRadius: 10, topTrailingRadius: 10))
                    .contextMenu(menuItems: {
                        Button("Delete task", role: .destructive, action: {
                            withAnimation(.easeInOut) {
                                contex.delete(task)
                                try? contex.save()
                            }
                        })
                        Button("Edit task", role: .destructive, action: {
                            withAnimation(.easeInOut) {
                                isShowingTaskEdit.toggle()
                            }
                        })
                    })
                } actions: {
                    Action(tint: .blue, icon: "pencil") {
                        withAnimation(.easeInOut) {
                            isShowingTaskEdit.toggle()
                        }
                    }
                    Action(tint: .red, icon: "trash.fill") {
                        withAnimation(.easeInOut) {
                            contex.delete(task)
                            try? contex.save()
                        }
                    }
                }
            }
            .onTapGesture {
                // Toggle the sheet when the cell is tapped
                isShowingTaskDetail.toggle()
            }
            .offset(x: -8)
            .strikethrough(task.isCompleted, pattern: .solid, color: .black)
        }
        .sheet(isPresented: $isShowingTaskEdit, content: {
            EditTaskView(task: task)
                .presentationDetents([.height(450)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
        })
        .sheet(isPresented: $isShowingTaskDetail, content: {
            DetailTaskView(task: task)
                .presentationDetents([.height(450)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
        })
        .background(.white)
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
