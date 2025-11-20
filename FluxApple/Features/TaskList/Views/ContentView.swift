//
//  ContentView.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.sortOrder) private var tasks: [Task]
    @State private var isShowingAddTask = false

    var body: some View {
        NavigationStack {
            TaskListContent(
                tasks: tasks,
                onToggleTask: toggleTask,
                onDeleteTasks: deleteTasks
            )
            .navigationTitle("Flux")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    AddTaskButton(onTap: { isShowingAddTask = true })
                }
            }
            .sheet(isPresented: $isShowingAddTask) {
                AddTaskView(
                    onAddTask: addTask,
                    onDismiss: { isShowingAddTask = false }
                )
            }
        }
    }

    private func addTask(title: String) {
        let taskService = TaskService(modelContext: modelContext)
        _ = try? taskService.createTask(title: title)
    }

    private func toggleTask(_ task: Task) {
        let taskService = TaskService(modelContext: modelContext)
        _ = try? taskService.toggleTaskCompletion(task)
    }

    private func deleteTasks(at offsets: IndexSet) {
        let taskService = TaskService(modelContext: modelContext)
        for index in offsets {
            _ = try? taskService.deleteTask(tasks[index])
        }
    }
}

private struct TaskListContent: View {
    let tasks: [Task]
    let onToggleTask: (Task) -> Void
    let onDeleteTasks: (IndexSet) -> Void

    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskRowView(
                    task: task,
                    onToggle: { onToggleTask(task) }
                )
            }
            .onDelete(perform: onDeleteTasks)
        }
    }
}

private struct AddTaskButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
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

            VStack(alignment: .leading, spacing: 4) {
                TaskTitleText(
                    title: task.title,
                    isCompleted: task.isCompleted
                )

                if task.priority != .p4 || task.status != .inbox {
                    TaskMetadata(
                        priority: task.priority,
                        status: task.status
                    )
                }
            }

            Spacer()

            if task.priority != .p4 {
                PriorityIndicator(priority: task.priority)
            }
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
    let onAddTask: (String) -> Void
    let onDismiss: () -> Void
    @State private var taskTitle = ""

    var body: some View {
        NavigationStack {
            Form {
                TaskTitleField(taskTitle: $taskTitle)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    CancelButton(onCancel: onDismiss)
                }
                ToolbarItem(placement: .confirmationAction) {
                    AddButton(
                        taskTitle: taskTitle,
                        onAdd: {
                            onAddTask(taskTitle)
                            onDismiss()
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

private struct CancelButton: View {
    let onCancel: () -> Void

    var body: some View {
        Button("Cancel") {
            onCancel()
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

private struct TaskMetadata: View {
    let priority: Priority
    let status: TaskStatus

    var body: some View {
        HStack(spacing: 8) {
            if priority != .p4 {
                Text(priority.displayName)
                    .font(.caption)
                    .foregroundStyle(priority.color)
            }

            if status != .inbox {
                Text(status.displayName)
                    .font(.caption)
                    .foregroundStyle(status.color)
            }
        }
    }
}

private struct PriorityIndicator: View {
    let priority: Priority

    var body: some View {
        Circle()
            .fill(priority.color)
            .frame(width: 8, height: 8)
    }
}


#Preview {
    ContentView()
}
