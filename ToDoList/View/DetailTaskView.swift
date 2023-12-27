import SwiftUI

struct DetailTaskView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .tint(.red)
            })
            .padding(.top, 15)
            .hSpacing(.leading)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Название:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 40)
                    .foregroundColor(Color.white)
                    .overlay(
                        Text(task.title)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .padding(.leading, 8)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Тень
            }
            .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Описание:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(minHeight: 60)
                    .foregroundColor(Color.white)
                    .overlay(
                        Text(task.taskDescription)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .padding(.leading, 8)
                    )
                
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            
            .navigationBarTitle("Детали задачи", displayMode: .inline)
        }
        .padding(10)
    }
}
