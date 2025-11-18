//
//  TaskRepository.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import Foundation

protocol TaskRepositoryProtocol {
    func getAllTasks() -> [Task]
    func addTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(id: UUID)
    func deleteTasks(ids: [UUID])
}

final class TaskRepository: TaskRepositoryProtocol {
    private var tasks: [Task]

    init(initialTasks: [Task] = []) {
        self.tasks = initialTasks
    }

    func getAllTasks() -> [Task] {
        return tasks
    }

    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
        }
    }

    func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
    }

    func deleteTasks(ids: [UUID]) {
        tasks.removeAll { ids.contains($0.id) }
    }
}
