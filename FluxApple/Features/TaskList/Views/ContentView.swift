//
//  ContentView.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = TaskListViewModel()

    var body: some View {
        NavigationStack {
            TaskListContent(viewModel: viewModel)
                .navigationTitle("Flux")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        AddTaskButton(viewModel: viewModel)
                    }
                }
                .sheet(isPresented: $viewModel.isShowingAddTask) {
                    AddTaskView(viewModel: viewModel)
                }
        }
    }
}

private struct TaskListContent: View {
    let viewModel: TaskListViewModel

    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                TaskRowView(
                    task: task,
                    onToggle: { viewModel.toggleTask(id: task.id) }
                )
            }
            .onDelete(perform: viewModel.deleteTasks)
        }
    }
}

private struct AddTaskButton: View {
    let viewModel: TaskListViewModel

    var body: some View {
        Button(action: viewModel.showAddTask) {
            Image(systemName: "plus")
        }
    }
}

struct TaskRowView: View {
    let task: Task
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            TaskCheckButton(
                isCompleted: task.isCompleted,
                onToggle: onToggle
            )

            TaskTitleText(
                title: task.title,
                isCompleted: task.isCompleted
            )
        }
    }
}

private struct TaskCheckButton: View {
    let isCompleted: Bool
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isCompleted ? Color.fluxSuccess : Color.fluxPrimary)
        }
        .buttonStyle(.plain)
    }
}

private struct TaskTitleText: View {
    let title: String
    let isCompleted: Bool

    var body: some View {
        Text(title)
            .strikethrough(isCompleted)
            .foregroundStyle(isCompleted ? .secondary : .primary)
    }
}

struct AddTaskView: View {
    let viewModel: TaskListViewModel
    @State private var taskTitle = ""
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TaskTitleField(taskTitle: $taskTitle)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    CancelButton(dismiss: dismiss)
                }
                ToolbarItem(placement: .confirmationAction) {
                    AddButton(
                        taskTitle: taskTitle,
                        onAdd: {
                            viewModel.addTask(title: taskTitle)
                            viewModel.dismissAddTask()
                        }
                    )
                }
            }
        }
    }
}

private struct TaskTitleField: View {
    @Binding var taskTitle: String

    var body: some View {
        TextField("Task title", text: $taskTitle)
            .autocorrectionDisabled()
    }
}

private struct CancelButton: View{
    let dismiss: DismissAction

    var body: some View {
        Button("Cancel") {
            dismiss()
        }
    }
}

private struct AddButton: View {
    let taskTitle: String
    let onAdd: () -> Void

    var body: some View {
        Button("Add") {
            onAdd()
        }
        .disabled(taskTitle.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}


#Preview {
    ContentView()
}
