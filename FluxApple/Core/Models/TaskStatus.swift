//
//  TaskStatus.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/21/25.
//

import Foundation
import SwiftUI

enum TaskStatus: String, Codable, CaseIterable {
    case inbox
    case active
    case completed
    case archived

    var displayName: String {
        switch self {
        case .inbox: return "Inbox"
        case .active: return "Active"
        case .completed: return "Completed"
        case .archived: return "Archived"
        }
    }

    var isTerminal: Bool {
        return self == .completed || self == .archived
    }

    var color: Color {
        switch self {
        case .inbox: return .secondary
        case .active: return .fluxPrimary
        case .completed: return .fluxSuccess
        case .archived: return .gray
        }
    }
}
