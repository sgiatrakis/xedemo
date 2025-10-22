//
//  XeAutoCompleteTextField.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import SwiftUI

struct XeAutoCompleteTextField: View {
    let title: String
    var placeholder: String = placeholderDefaultText

    @Binding var text: String

    var suggestionsProvider: ((String) async -> [String])?

    @State private var suggestions: [String] = []
    @State private var showSuggestions: Bool = false
    @State private var isLoading: Bool = false
    @State private var ignoreNextChange: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: DesignMetric.extraSmallSmall) {
            Text(title)
                .font(.system(size: DesignMetric.mediumLarge, weight: .bold))
                .padding(.vertical, DesignMetric.small)

            TextField(text, text: $text, prompt: Text(placeholder))
                .padding(DesignMetric.medium)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .onChange(of: text) { _, newValue in
                    if ignoreNextChange {
                        ignoreNextChange = false
                        return
                    }
                    Task { await handleTextChange(newValue) }
                }
                .overlay(
                    Group {
                        if isLoading {
                            ProgressView()
                                .padding(.trailing, DesignMetric.mediumLarge)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                )

            if showSuggestions && !suggestions.isEmpty {
                VStack(spacing: 0) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button(action: {
                            Task { await selectSuggestion(suggestion) }
                            // swiftlint:disable:next multiple_closures_with_trailing_closure
                        }) {
                            Text(suggestion)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, DesignMetric.medium)
                                .padding(.horizontal)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(.top, DesignMetric.small)
            }
        }
    }

    // MARK: - Actions

    private func handleTextChange(_ newValue: String) async {
        guard newValue.count >= 3 else {
            suggestions = []
            showSuggestions = false
            isLoading = false
            return
        }

        guard let provider = suggestionsProvider else { return }
        isLoading = true
        let results = await provider(newValue)
        suggestions = results
        showSuggestions = !results.isEmpty
        isLoading = false
    }

    private func selectSuggestion(_ suggestion: String) async {
        text = suggestion
        showSuggestions = false
        suggestions = []
    }
}

#Preview {
    XeAutoCompleteTextField(title: "Location", text: Binding.constant("Athens"))
}
