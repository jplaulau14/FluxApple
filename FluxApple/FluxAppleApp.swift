//
//  FluxAppleApp.swift
//  FluxApple
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI
import SwiftData

@main
struct FluxAppleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.fluxPrimary)
        }
        .modelContainer(sharedModelContainer)
    }
}
