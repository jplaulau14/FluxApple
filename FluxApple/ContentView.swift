//
//  ContentView.swift
//  Flux
//
//  Created by Pats Laurel on 11/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Flux")
                .font(.title)
                .padding()
            
            Text("No tasks yet")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
