//
//  ListaCalciatoriView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject var apiCall = APICall()
    @State private var players: [PlayerInfo] = []
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
                            ForEach(players, id: \.player.playerId) { player in
                                PlayerCell(player: player)
                            }
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
                    let fetchedPlayers = try await apiCall.fetchPlayers()
                        
                    for player in fetchedPlayers {
                        let playerInfo = PlayerInfo(player: player)
                        players.append(playerInfo)
                        modelContext.insert(playerInfo)
                    }
                    await sorted()
                    isLoading = false
                } catch {
                    apiError = error
                }
            }
        }
    }
    
    private func sorted() async {
        // se il team é lo stesso
        // sorta tra nomi
        // altrimenti sorta tra team
        let sortedPlayers = players.sorted {
            if $0.player.teamAbbreviation == $1.player.teamAbbreviation {
                return $0.player.playerName < $1.player.playerName
            } else {
                return $0.player.teamAbbreviation < $1.player.teamAbbreviation
            }
        }

        
        players = sortedPlayers
    }
}

#Preview {
    PlayerListView()
}
