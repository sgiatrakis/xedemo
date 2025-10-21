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
    var isDisabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: DesignMetric.medium, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DesignMetric.medium)
                .background(color.opacity(isDisabled ? 0.5 : 1.0))
                .cornerRadius(12)
        }.disabled(isDisabled)
    }
}

#Preview {
    XeButton(title: "Test", color: .green) {}
}
