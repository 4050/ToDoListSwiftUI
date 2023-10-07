import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var contex

    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var selectedDate = Date()
    @State private var selectedColorIndex: String = Colors.taskColor1.rawValue
    @State private var isCompleted = false
    
    let taskColors: [String] = [Colors.taskColor1.rawValue, Colors.taskColor2.rawValue, Colors.taskColor3.rawValue, Colors.taskColor4.rawValue, Colors.taskColor5.rawValue]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.leading)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                TextField("Go for a walk", text: $taskName)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
            })
            .padding(.top, 5)
            
            HStack(spacing: 12, content: {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    DatePicker("", selection: $selectedDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                        .environment(\.locale, Locale(identifier: "en_GB"))
                })
                .padding(.top, 5)
                .padding(.trailing, -15)
                
                VStack(alignment: .leading, spacing: 16, content: {
                    Text("Task Color")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 0, content: {
                        ForEach(taskColors, id: \.self) { color in
                            Circle()
                                .fill(Color(color))
                                .frame(width: 20, height: 20)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(selectedColorIndex == color ? 1: 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture() {
                                    withAnimation(.snappy) {
                                        selectedColorIndex = color
                                    }
                                }
                            
                        }
                    })
                })
                .padding(.top, 5)
            })
            VStack(alignment: .leading, spacing: 15, content: {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Description Task")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextEditor(text: $taskDescription)
                        .padding(.horizontal, 15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                })
                .padding(.top, 5)
                
                Button(action: {
                    let task = TaskModel(title: taskName, taskDescription: taskDescription, dueDate: selectedDate, creationDate: Date.init(), isCompleted: isCompleted, color: selectedColorIndex)
                    withAnimation {
                        contex.insert(task)
                        presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    Text("Create Task")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(Color(selectedColorIndex), in: .rect(cornerRadius: 20))
                })
                .disabled(taskName == "")
                .opacity(taskName == "" ? 0.5 : 1)
            })
        })
        .padding(15)
    }
    
}
