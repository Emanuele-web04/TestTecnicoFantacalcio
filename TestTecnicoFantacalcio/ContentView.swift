//
//  ContentView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PlayerListView()
                .tabItem {
                    Label("Lista calciatori", systemImage: "person")
                }
            ProgressView()
                .tabItem {
                    Label("Preferiti", systemImage: "star")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PlayersList.self, inMemory: true)
}
