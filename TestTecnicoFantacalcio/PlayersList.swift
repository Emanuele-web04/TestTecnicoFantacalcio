//
//  Item.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class PlayersList {
    var players: [Player] = []
    
    init(players: [Player] = []) {
        self.players = players
    }
}
