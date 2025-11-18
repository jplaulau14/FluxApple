//
//  ContentView.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    
    let sampleTasks = [
        Task(title: "Buy groceries"),
        Task(title: "Walk the dog", isCompleted: true),
        Task(title: "Go for a walk")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sampleTasks) { task in
                    TaskRowView(task: task)
                }
            }
            .navigationTitle("Flux")
        }
    }
}

struct TaskRowView: View {
    let task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill": "circle")
                .foregroundStyle(task.isCompleted ? .green: .gray)
            
            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundStyle(task.isCompleted ? .secondary: .primary)
        }
    }
}

#Preview {
    ContentView()
}
