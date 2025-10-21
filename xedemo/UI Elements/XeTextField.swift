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
    let invalidError: String?

    var onEditingChanged: (() -> Void)?

    @Binding var text: String
    @FocusState private var isFocused: Bool

    init(title: String,
         text: Binding<String>,
         placeholder: String = placeholderDefaultText,
         invalidError: String? = nil,
         onEditingChanged: (() -> Void)? = nil) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.invalidError = invalidError
        self.onEditingChanged = onEditingChanged
    }

    var body: some View {
        VStack(alignment: .leading, spacing: DesignMetric.small) {
            Text(title)
                .font(.system(size: DesignMetric.mediumLarge, weight: .bold))
                .padding(.vertical, DesignMetric.small)
            if let invalidError {
                Text(invalidError)
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .onChange(of: isFocused) { _, newValue in
                    if newValue && (invalidError != nil) {
                        onEditingChanged?()
                    }
                }
                .onChange(of: text) {
                    if invalidError != nil {
                        onEditingChanged?()
                    }
                }
                .padding(DesignMetric.medium)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke((invalidError != nil) ? Color.red : Color.clear, lineWidth: 1)
                  )
        }
    }
}

#Preview {
    XeTextField(title: "Location",
                text: Binding.constant(""),
                placeholder: "Test")
}
