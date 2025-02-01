//
//  FavouritesView.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI
import SwiftData

struct FavouritesView: View {
    
    @Query var players: [PlayerInfo]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack {
                        Rectangle()
                            .hAlign(.center)
                            .frame(height: 150, alignment: .top)
                            .ignoresSafeArea()
                        ForEach(favourites, id: \.player.playerId) { player in
                            PlayerCell(player: player)
                        }
                    }
                }
                .vAlign(.top)
                .hAlign(.center)
            }
            
        }
    }
    
    private var favourites: [PlayerInfo] {
        let filtered = players.filter {
            $0.isFavourite
        }
        
        return filtered
    }
}

#Preview {
    FavouritesView()
}
