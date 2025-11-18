//
//  Task.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/18/25.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}
