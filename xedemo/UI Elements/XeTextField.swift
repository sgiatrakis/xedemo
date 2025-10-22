//
//  XeTextField.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import SwiftUI

struct XeTextField: View {
    let title: String
    let placeholder: String

    @Binding var text: String

    init(title: String,
         text: Binding<String>,
         placeholder: String = placeholderDefaultText) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignMetric.small) {
            Text(title)
                .font(.system(size: DesignMetric.mediumLarge, weight: .bold))
                .padding(.vertical, DesignMetric.small)
            TextField(text, text: $text, prompt: Text(placeholder))
                .padding(DesignMetric.medium)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

#Preview {
    XeTextField(title: "Location",
                text: Binding.constant(""),
                placeholder: "Test")
}
