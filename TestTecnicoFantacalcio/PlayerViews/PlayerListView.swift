//
//  ListaCalciatoriView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject var apiCall = APICall()
    @State private var players: [Player] = []
    @State private var apiError: Error? = nil
    @State private var isLoading = true
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
                            ForEach(players, id: \.playerId) { player in
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
                    players = try await apiCall.fetchPlayers()
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
            if $0.teamAbbreviation == $1.teamAbbreviation {
                return $0.playerName < $1.playerName
            } else {
                return $0.teamAbbreviation < $1.teamAbbreviation
            }
        }

        
        players = sortedPlayers
    }
}

#Preview {
    PlayerListView()
}
