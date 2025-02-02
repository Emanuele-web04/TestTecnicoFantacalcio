//
//  FavViewModel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 02/02/25.
//

import SwiftUI

class FavViewModel: ObservableObject {
    @Published var favourites: [PlayerInfo] = []
    @Published var sponsorToShow: MainObject? = nil
}
