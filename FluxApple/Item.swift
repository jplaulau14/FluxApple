//
//  Item.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/18/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
