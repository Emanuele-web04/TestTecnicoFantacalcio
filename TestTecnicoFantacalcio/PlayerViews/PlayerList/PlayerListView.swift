//
//  ListaCalciatoriView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData

struct PlayerListView: View {
    @ObservedObject var apiCall = APICall()
    @Query var players: [PlayerInfo]
    @State private var sortedPlayers: [PlayerInfo] = []
    @State private var apiError: Error? = nil
    @State private var isLoading = true
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        Rectangle()
                            .hAlign(.center)
                            .frame(height: 150, alignment: .top)
                            .ignoresSafeArea()
                        if let apiError {
                            Text(apiError.localizedDescription)
                        } else {
                            PlayersCells(players: sortedPlayers)
                        }
                    }
                }
                .vAlign(.top)
                .hAlign(.center)
            }
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .task {
                do {
                    try await fetchAndSort()
                } catch {
                    apiError = error
                }
            }
        }
    }
    
    private func fetchAndSort() async throws {
        let fetchedPlayers = try await apiCall.fetchPlayers()
        populatePlayers(from: fetchedPlayers)
        
        await sorted()
        isLoading = false
    }
    
    private func populatePlayers(from fetchedPlayers: [Player]) {
        if players.isEmpty {
            for player in fetchedPlayers {
                let playerInfo = PlayerInfo(player: player)
                modelContext.insert(playerInfo)
            }
             
            // forziamo subito il save in modo tale da sortare subito dopo
            try? modelContext.save()
        }
    }
    
    private func sorted() async {
        // se il team é lo stesso
        // sorta tra nomi
        // altrimenti sorta tra team
        let sorted = players.sorted {
            if $0.player.teamAbbreviation == $1.player.teamAbbreviation {
                return $0.player.playerName < $1.player.playerName
            } else {
                return $0.player.teamAbbreviation < $1.player.teamAbbreviation
            }
        }
        
        await MainActor.run {
            sortedPlayers = sorted
        }
    }
}

#Preview {
    PlayerListView()
}
