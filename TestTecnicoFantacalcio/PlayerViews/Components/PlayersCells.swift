//
//  PlayersCells.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct PlayersCells: View {
    let players: [PlayerInfo]
    var body: some View {
        ForEach(players, id: \.player.playerId) { player in
            PlayerCell(player: player)
        }
    }
}

#Preview {
    PlayersCells(players: [PlayerPlaceholder.sdPlaceholder])
}
