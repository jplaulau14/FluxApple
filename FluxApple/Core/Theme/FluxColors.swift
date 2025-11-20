//
//  FluxColors.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI

extension Color {
    // MARK: - Flux Brand Colors

    /// Primary brand color - Indigo
    static let fluxPrimary = Color(red: 99/255, green: 102/255, blue: 241/255) // #6366F1

    /// Primary color for dark mode
    static let fluxPrimaryLight = Color(red: 129/255, green: 140/255, blue: 248/255) // #818CF8

    /// Success/Completed state - Emerald Green
    static let fluxSuccess = Color(red: 16/255, green: 185/255, blue: 129/255) // #10B981

    /// Accent color - Purple
    static let fluxAccent = Color(red: 139/255, green: 92/255, blue: 246/255) // #8B5CF6

    // MARK: - Priority Colors

    /// P1 Priority - Red (High)
    static let fluxPriorityHigh = Color(red: 239/255, green: 68/255, blue: 68/255) // #EF4444

    /// P2 Priority - Orange (Medium)
    static let fluxPriorityMedium = Color(red: 249/255, green: 115/255, blue: 22/255) // #F97316

    /// P3 Priority - Blue (Low)
    static let fluxPriorityLow = Color(red: 59/255, green: 130/255, blue: 246/255) // #3B82F6

    /// P4 Priority - Gray (None)
    static let fluxPriorityNone = Color.secondary
}
