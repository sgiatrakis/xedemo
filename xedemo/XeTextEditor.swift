//
//  XeTextEditor.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import SwiftUI

struct XeTextEditor: View {
    let title: String
    let placeholder: String

    @FocusState private var isFocused: Bool
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
            ZStack(alignment: .topLeading) {
                if text.isEmpty && !isFocused {
                    Text(placeholder)
                        .foregroundColor(Color(uiColor: .placeholderText))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                }
                TextEditor(text: $text)
                    .focused($isFocused)
                    .scrollContentBackground(.hidden)
                    .padding(DesignMetric.small)
                    .frame(height: 100)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    XeTextEditor(title: "Description",
                 text: Binding.constant(""),
                 placeholder: "Test...")
}
