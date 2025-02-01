//
//  Item.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class PlayerInfo {
    var player: Player
    
    init(player: Player) {
        self.player = player
    }
}

