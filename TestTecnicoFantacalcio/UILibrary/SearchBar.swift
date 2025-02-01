//
//  SearchBar.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct SearchBar: View {
    @FocusState var isFocused
    @Binding var search: String
    let prompt: String
    @State var searchAction: () -> ()
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.placeholder)
            TextField(prompt, text: $search)
                .onSubmit {
                    if !search.isEmpty {
                        searchAction()
                    }
                    isFocused = false
                }
            Spacer(minLength: 0)
            emptySearch
        }
        .padding(10)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.secondary.opacity(0.1))
        }
    }
    
    @ViewBuilder
    private var emptySearch: some View {
        if !search.isEmpty {
            Button {
                search = ""
                isFocused = false
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    SearchBar(search: .constant(""), prompt: "Cerca giocatori...", searchAction: {})
}
