import SwiftUI

struct DetailTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var contex
    @State private var isShowingTaskEdit = false
    @Bindable var task: TaskModel
    var color: Color {
        Color(task.color).opacity(0.2)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .tint(.red)
            }
            
            VStack(alignment: .leading, spacing: 15, content: {
                Text(task.title)
                    .lineLimit(nil)
                    .font(.title2)
                    .foregroundColor(.primary)
            })
                VStack(alignment: .leading, spacing: 15, content: {
                    Text("Описание:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    ScrollView(.vertical) {
                        Text(task.taskDescription)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .scrollIndicators(.visible)
                })
                .padding(.bottom, 15)
            
            HStack (spacing: 0, content: {
                Button(action: {
                    withAnimation(.easeInOut) {
                        contex.delete(task)
                        try? contex.save()
                    }
                }) {
                    Text("Удалить")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(color)
                        .clipShape(Capsule())
                }
                .padding(.trailing, 5) // Добавлен отступ между кнопками
                
                Button(action: {
                    toggleTaskCompletion()
                }) {
                    Text("Выполнено")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(color)
                        .clipShape(Capsule())
                }
                
            })
            
            Button(action: {
                withAnimation(.easeInOut) {
                    isShowingTaskEdit.toggle()
                }
            }) {
                Text("Редактировать")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(color)
                    .clipShape(Capsule())
            } .padding(5)
        })
        .padding(15)
        .sheet(isPresented: $isShowingTaskEdit, content: {
            EditTaskView(task: task)
                .presentationDetents([.height(450)])
                .interactiveDismissDisabled()
                .presentationCornerRadius(30)
        })
    }
    
    private func toggleTaskCompletion() {
        task.isCompleted.toggle()
        try? contex.save()
    }
}
