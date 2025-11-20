//
//  Task.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/18/25.
//

import Foundation
import SwiftData

@Model
final class Task {
    var id: UUID
    var title: String
    var taskDescription: String?
    var dueDate: Date?
    var dueTime: Date?
    var startDate: Date?
    var priority: Priority
    var status: TaskStatus
    var estimatedDuration: TimeInterval?
    var createdAt: Date
    var completedAt: Date?
    var sortOrder: Int

    // Placeholder relationships for future blocks
    // var project: Project?
    // var section: Section?
    // var labels: [Label]
    // var parentTask: Task?
    // var subtasks: [Task]

    init(
        id: UUID = UUID(),
        title: String,
        taskDescription: String? = nil,
        dueDate: Date? = nil,
        dueTime: Date? = nil,
        startDate: Date? = nil,
        priority: Priority = .p4,
        status: TaskStatus = .inbox,
        estimatedDuration: TimeInterval? = nil,
        createdAt: Date = Date(),
        completedAt: Date? = nil,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.dueDate = dueDate
        self.dueTime = dueTime
        self.startDate = startDate
        self.priority = priority
        self.status = status
        self.estimatedDuration = estimatedDuration
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.sortOrder = sortOrder
    }
}

// MARK: - Computed Properties

extension Task {
    var isCompleted: Bool {
        return status == .completed
    }

    var isOverdue: Bool {
        guard let dueDate = dueDate else { return false }
        return dueDate < Date() && !isCompleted
    }

    var isToday: Bool {
        guard let dueDate = dueDate else { return false }
        return Calendar.current.isDateInToday(dueDate)
    }
}
