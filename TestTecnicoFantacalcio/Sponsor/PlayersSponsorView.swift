////
////  PlayersSponsorView.swift
////  TestTecnicoFantacalcio
////
////  Created by Emanuele Di Pietro on 01/02/25.
////
//
//import SwiftUI
//import Kingfisher
//
//struct PlayersSponsorView: View {
//    let apiCall = APISponsorCall()
//    //@State private var sponsors: [Sponsor] = []
//    @State private var apiError: Error? = nil
//    @Query var sponsors: [Sponsor]
//
//    let nullEndpoint = "https://content.fantacalcio.it/test/Fav-Default.png"
//    var body: some View {
//        VStack {
//            ScrollView {
//                LazyVStack {
//                    ForEach(sponsors, id: \.sectionId) { sponsor in
//                        Main(mains: sponsor.main)
//                    }
//                }
//            }
//        }
//        .task {
//            do {
//                sponsors = try await apiCall.fetchSponsors()
//            } catch {
//                apiError = error
//            }
//        }
//    }
//    
//    private func Main(mains: [MainObject]) -> some View {
//        ForEach(mains, id: \.image) { main in
//            if let tapUrl = main.tapUrl, let url = URL(string: tapUrl) {
//                Button {
//                    // se non si vuole usare UIApplication
//                    // si puo anche usare NavigationLink con destination e label
//                    UIApplication.shared.open(url)
//                } label: {
//                    if let validURL = URL(string: main.image) {
//                        KFImage(validURL)
//                    }
//                }
//            } else {
//                if let url = URL(string: nullEndpoint) {
//                    KFImage(url)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    PlayersSponsorView()
//}
