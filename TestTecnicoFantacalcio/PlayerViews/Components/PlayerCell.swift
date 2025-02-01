//
//  PlayerCell.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

// About Kingfisher e perché ho preferito la libreria ad AsyncImage
// "https://medium.com/@mathferreiranasc12/using-the-kingfisher-library-in-ios-development-1673e8b24a00"

import SwiftUI
import Kingfisher

struct PlayerCell: View {
    @Bindable var player: PlayerInfo
    var body: some View {
        HStack {
            PlayerImage(imageURL: player.player.imageURL)
            PlayerNameTeam(player: player.player)
            PlayerStats(player: player.player)
            ToggleFavourite(player: player)
        }
        .hAlign(.center)
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        }
        .safeAreaPadding(.horizontal)
        .safeAreaPadding(.vertical, 5)
    }
}

fileprivate struct PlayerStats: View {
    let player: Player
    var body: some View {
        HStack {
            Text("\(player.gamesPlayed)")
            Text(String(format: "%.2f", player.averageGrade))
            Text(String(format: "%.2f", player.averageFantaGrade))
        }
        .modifier(LabelModifier(color: .secondary))
        .hAlign(.center)
    }
}

fileprivate struct PlayerNameTeam: View {
    let player: Player
    var body: some View {
        VStack(alignment: .leading) {
            Text(player.playerName)
                .font(.headline)
            Text(player.teamAbbreviation)
                .modifier(LabelModifier(color: .primary))
        }
        .hAlign(.leading)
    }
}

fileprivate struct ToggleFavourite: View {
    @Bindable var player: PlayerInfo
    var body: some View {
        Button {
            withAnimation {
                player.isFavourite.toggle()
            }
        } label: {
            Image(systemName: toggle ? "star.fill" : "star")
                .imageScale(.large)
                .foregroundStyle(toggle ? .blue : .primary)
        }
    }
    
    private var toggle: Bool {
        return player.isFavourite
    }
}

fileprivate struct PlayerImage: View {
    let imageURL: String
    var body: some View {
        if let validURL = URL(string: imageURL) {
            KFImage(validURL)
                .placeholder {
                    ProgressView()
                }
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(10)
                .background(Color(.systemGray5), in: Circle())
        } else {
            Circle()
                .fill(Color(.systemGray5))
                .frame(width: 40, height: 40)
                .padding(10)
        }
    }
}

#Preview {
    PlayerCell(player: PlayerPlaceholder.sdPlaceholder)
}
