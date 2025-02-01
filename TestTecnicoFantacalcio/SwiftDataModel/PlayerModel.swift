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
    var isFavourite: Bool = false
    
    init(player: Player, isFavourite: Bool = false) {
        self.player = player
        self.isFavourite = isFavourite
    }
}

