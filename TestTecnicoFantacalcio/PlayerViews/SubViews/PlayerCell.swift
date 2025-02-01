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
    let player: Player

    var body: some View {
        HStack {
            PlayerImage(imageURL: player.imageURL)
            PlayerNameTeam(player: player)
            PlayerStats(player: player)
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
        .textScale(.secondary)
        .foregroundStyle(.secondary)
    }
}

fileprivate struct PlayerNameTeam: View {
    let player: Player
    var body: some View {
        VStack(alignment: .leading) {
            Text(player.playerName)
                .font(.headline)
            Text(player.teamAbbreviation)
                .textScale(.secondary)
                .foregroundStyle(.secondary)
        }
        .hAlign(.leading)
    }
}

fileprivate struct ToggleFavourite: View {
    @Binding var player: Player
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "star")
        }
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
    PlayerCell(player: PlayerPlaceholder.placeholder)
}
