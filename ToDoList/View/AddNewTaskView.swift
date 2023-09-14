import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    let addTodo: (Task) -> Void
    @State private var taskName = ""
    @State private var selectedDate = Date() // Initialize with the current date and time
    @State private var selectedColorIndex = 0
    @State private var isCompleted = false
    
    let taskColors: [Color] = [.red, .blue, .green, .yellow, .purple] // Define your basic colors
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                    
                    DatePicker("Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .environment(\.locale, Locale(identifier: "en_GB"))
                }
                
                Section(header: Text("Task Color")) {
                    HStack {
                        ForEach(0..<taskColors.count, id: \.self) { index in
                            Circle()
                                .fill(taskColors[index])
                                .frame(width: 20, height: 20)
                                .overlay(
                                    Circle()
                                        .stroke(selectedColorIndex == index ? Color.black : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        selectedColorIndex = index
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("Add Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let task = Task(title: taskName, dueDate: selectedDate, isCompleted: isCompleted, color: taskColors[selectedColorIndex])
                    addTodo(task)
                    presentationMode.wrappedValue.dismiss()
                }
                    .disabled(taskName.isEmpty) // Disable the "Save" button if taskName is empty
            )
        }
    }
}

