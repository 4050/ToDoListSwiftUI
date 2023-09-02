//
//  ContentView.swift
//  ToDoList
//
//  Created by Станислав on 02.09.2023.
//

import SwiftUI

struct ContentView: View {

    @State private var tasks: [Task] = [Task(title: "123"), Task(title: "123"), Task(title: "123"), Task(title: "123")]
    
    @State private var currentDate: Date = .init()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0, content: {
                HeaderView()
                ScrollView(.vertical) {
                    VStack( alignment: .center, content: {
                        TaskView()
                    })
                }
            })
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        
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
    }
    
    @ViewBuilder
    func TaskView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach($tasks) { $task in
                TaskRowView(task: $task)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
