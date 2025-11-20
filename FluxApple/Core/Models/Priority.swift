//
//  Priority.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/21/25.
//

import Foundation
import SwiftUI

enum Priority: Int, Codable, CaseIterable {
    case p1 = 1
    case p2 = 2
    case p3 = 3
    case p4 = 4

    var displayName: String {
        switch self {
        case .p1: return "High"
        case .p2: return "Medium"
        case .p3: return "Low"
        case .p4: return "None"
        }
    }

    var sortOrder: Int {
        return rawValue
    }

    var color: Color {
        switch self {
        case .p1: return .fluxPriorityHigh
        case .p2: return .fluxPriorityMedium
        case .p3: return .fluxPriorityLow
        case .p4: return .fluxPriorityNone
        }
    }
}
