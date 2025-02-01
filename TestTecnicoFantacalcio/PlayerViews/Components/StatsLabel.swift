//
//  StatsLabel.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct StatsLabel: View {
    var body: some View {
        HStack {
            Text("Calciatori")
                .hAlign(.leading)
            HStack {
                Text("PG")
                Text("MV")
                Text("MFV")
            }
            .hAlign(.trailing)
        }
        .hAlign(.center)
        .padding(.horizontal)
        .padding([.top, .trailing], 10)
        .modifier(LabelModifier(color: .primary.opacity(0.7)))
        .fontWeight(.semibold)
        .font(.body)
    }
}

#Preview {
    StatsLabel()
}
