//
//  TaskListViewModel.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import Foundation
import Observation

@Observable
final class TaskListViewModel {
    private(set) var tasks: [Task] = []
    var isShowingAddTask = false

    private let repository: TaskRepositoryProtocol

    init(repository: TaskRepositoryProtocol = TaskRepository(
        initialTasks: [
            Task(title: "Buy groceries"),
            Task(title: "Walk the dog", isCompleted: true),
            Task(title: "Read a book")
        ]
    )) {
        self.repository = repository
        self.tasks = repository.getAllTasks()
    }

    func addTask(title: String) {
        guard !title.isEmpty else { return }

        let newTask = Task(title: title)
        repository.addTask(newTask)
        tasks = repository.getAllTasks()
    }

    func toggleTask(id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }

        var updatedTask = tasks[index]
        updatedTask.isCompleted.toggle()

        repository.updateTask(updatedTask)
        tasks = repository.getAllTasks()
    }

    func deleteTasks(at offsets: IndexSet) {
        let idsToDelete = offsets.map { tasks[$0].id }
        repository.deleteTasks(ids: idsToDelete)
        tasks = repository.getAllTasks()
    }

    func showAddTask() {
        isShowingAddTask = true
    }

    func dismissAddTask() {
        isShowingAddTask = false
    }
}
