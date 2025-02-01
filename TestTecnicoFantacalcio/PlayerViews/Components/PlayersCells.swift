//
//  PlayersCells.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct PlayersCells: View {
    let players: [PlayerInfo]
    var favouriteView = false
    var body: some View {
        ForEach(players, id: \.player.playerId) { player in
            PlayerCell(player: player, favouriteView: favouriteView)
        }
    }
}

#Preview {
    PlayersCells(players: [PlayerPlaceholder.sdPlaceholder])
}
