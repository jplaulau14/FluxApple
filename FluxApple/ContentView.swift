//
//  ContentView.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var tasks: [Task] = [
        Task(title: "Buy groceries"),
        Task(title: "Walk the dog", isCompleted: true),
        Task(title: "Read a book")
    ]

    @State private var newTaskTitle = ""
    @State private var showingAddTask = false

    var body: some View {
        NavigationStack {
            List {
                ForEach($tasks) { $task in
                    TaskRowView(task: $task)
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationTitle("Flux")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(tasks: $tasks, isPresented: $showingAddTask)
            }
        }
    }

    private func deleteTasks(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct TaskRowView: View {
    @Binding var task: Task

    var body: some View {
        HStack {
            Button(action: { task.isCompleted.toggle() }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.isCompleted ? Color.fluxSuccess : Color.fluxPrimary)
            }
            .buttonStyle(.plain)

            Text(task.title)
                .strikethrough(task.isCompleted)
                .foregroundStyle(task.isCompleted ? .secondary : .primary)
        }
    }
}

struct AddTaskView: View {
    @Binding var tasks: [Task]
    @Binding var isPresented: Bool
    @State private var taskTitle = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $taskTitle)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !taskTitle.isEmpty {
                            tasks.append(Task(title: taskTitle))
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
