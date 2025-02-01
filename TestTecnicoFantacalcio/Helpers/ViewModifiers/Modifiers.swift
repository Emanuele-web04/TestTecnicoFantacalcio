//
//  Modifiers.swift
//  TestTecnicoFantacalcio
//
//  Created by Emanuele Di Pietro on 01/02/25.
//

import SwiftUI

struct LabelModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundStyle(color)
    }
}
