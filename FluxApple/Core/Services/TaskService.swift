//
//  TaskService.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/21/25.
//

import Foundation
import SwiftData

final class TaskService {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // MARK: - Create

    func createTask(title: String) throws -> Task {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw TaskServiceError.emptyTitle
        }

        let task = Task(title: title)
        modelContext.insert(task)
        try modelContext.save()
        return task
    }

    // MARK: - Read

    func fetchAllTasks() throws -> [Task] {
        let descriptor = FetchDescriptor<Task>(
            sortBy: [SortDescriptor(\.sortOrder)]
        )
        return try modelContext.fetch(descriptor)
    }

    func fetchTask(byId id: UUID) throws -> Task? {
        let descriptor = FetchDescriptor<Task>(
            predicate: #Predicate { $0.id == id }
        )
        return try modelContext.fetch(descriptor).first
    }

    // MARK: - Update

    func updateTask(_ task: Task) throws {
        try modelContext.save()
    }

    func toggleTaskCompletion(_ task: Task) throws {
        if task.isCompleted {
            task.status = .active
            task.completedAt = nil
        } else {
            task.status = .completed
            task.completedAt = Date()
        }
        try modelContext.save()
    }

    // MARK: - Delete

    func deleteTask(_ task: Task) throws {
        modelContext.delete(task)
        try modelContext.save()
    }
}

// MARK: - Errors

enum TaskServiceError: LocalizedError {
    case emptyTitle

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Task title cannot be empty"
        }
    }
}
