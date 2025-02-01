//
//  ViewModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

class SharedViewModel {
    func sort(_ players: [PlayerInfo], in sortedPlayers: Binding<[PlayerInfo]>) async {
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
            sortedPlayers.wrappedValue = sorted
        }
    }
}
