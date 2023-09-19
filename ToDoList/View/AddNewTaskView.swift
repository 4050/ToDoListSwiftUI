import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    let addTodo: (Task) -> Void
    @State private var taskName = ""
    @State private var taskDescription = ""
    @State private var selectedDate = Date()
    @State private var selectedColorIndex = 0
    @State private var isCompleted = false
    
    let taskColors: [Color] = [.red, .blue, .green, .yellow, .purple] // Define your basic colors
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Task Name", text: $taskName)
                    taskColorStack()
                    DatePicker("Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                        .environment(\.locale, Locale(identifier: "en_GB"))
                }
                Section(header: Text("Task Details")) {
                    TextField("Task description", text: $taskDescription)
                    
                }
            }
            .navigationTitle("Add Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let task = Task(title: taskName, taskDescription: taskDescription, dueDate: selectedDate, isCompleted: isCompleted, color: taskColors[selectedColorIndex])
                    addTodo(task)
                    presentationMode.wrappedValue.dismiss()
                }
                    .disabled(taskName.isEmpty) // Disable the "Save" button if taskName is empty
            )
        }
    }
    @ViewBuilder
    func taskColorStack() -> some View {
        HStack {
            Text("Task Color")
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
            .hSpacing(.trailing)
            .padding([.horizontal], 15)
        }
    }
}
