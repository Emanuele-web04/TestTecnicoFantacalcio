//
//  SponsorImage.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 02/02/25.
//

import SwiftUI
import Kingfisher

struct SponsorImage: View {
    let sponsor: MainObject
    let nullEndpoint: String
    var body: some View {
        if let tapUrl = sponsor.tapUrl, let url = URL(string: tapUrl) {
            Button {
                openUrl(url)
            } label: {
                if let validURL = URL(string: sponsor.image) {
                    KFAsyncImage(validURL)
                }
            }
        } else {
            if let url = URL(string: nullEndpoint) {
                KFAsyncImage(url)
            }
        }
    }
    
    private func KFAsyncImage(_ validURL: URL) -> some View {
        KFImage(validURL)
            .placeholder {
                ProgressView()
            }
            .resizable()
            .hAlign(.center)
    }
    
    private func openUrl(_ url: URL) {
        // se non si vuole usare UIApplication
        // si puo anche usare NavigationLink con destination e label
        UIApplication.shared.open(url)
    }
}
