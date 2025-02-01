//
//  Item.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import Foundation
import SwiftData

@Model
final class PlayerInfo: Identifiable {
    var id: String = UUID().uuidString
    var player: Player
    var isFavourite: Bool = false
    
    init(id: String = UUID().uuidString, player: Player, isFavourite: Bool = false) {
        self.id = id
        self.player = player
        self.isFavourite = isFavourite
    }
}

