//
//  XeButton.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import SwiftUI

struct XeButton: View {
    let title: String
    let color: Color
    @State private var isPressed = false

    var body: some View {
        Button {
            // TODO: Action placeholder
            print("\(title) tapped")
        } label: {
            Text(title)
                .font(.system(size: DesignMetric.medium, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DesignMetric.medium)
                .background(color)
                .cornerRadius(12)
        }
    }
}

#Preview {
    XeButton(title: "Test", color: .green)
}
