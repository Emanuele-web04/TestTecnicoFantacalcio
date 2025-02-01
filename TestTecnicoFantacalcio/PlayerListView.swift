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
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Rectangle()
                        .hAlign(.center)
                        .frame(height: 150, alignment: .top)
                        .ignoresSafeArea()
                    if let apiError {
                        Text(apiError.localizedDescription)
                    } else {
                        ForEach(players, id: \.playerId) { player in
                            Text(player.playerName)
                        }
                    }
                }
                .vAlign(.top)
                .hAlign(.center)
            }
            .task {
                do {
                    players = try await apiCall.fetchPlayers()
                } catch {
                    apiError = error
                }
            }
        }
    }
}

#Preview {
    PlayerListView()
}
