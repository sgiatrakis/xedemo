//
//  ContentView.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var property = XeProperty()
    @State private var selectedSuggestion: AutoCompleteSuggestion?

    @ObservedObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("New Property Classified")
                        .font(.system(size: DesignMetric.large, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, DesignMetric.extraLarge)
                    XeTextField(title: "Title", text: $property.title)

                    XeAutoCompleteTextField<AutoCompleteSuggestion>(
                        title: "Location",
                        text: $property.location,
                        suggestionsProvider: { query in
                            await viewModel.fetchAutoCompleteSuggestions(input: query)
                        },
                        display: { $0.displayText },
                        onSelectSuggestion: { suggestion in
                            selectedSuggestion = suggestion
                        }
                    )
                    .onChange(of: property.location) { _, newValue in
                        if selectedSuggestion?.displayText != newValue {
                            selectedSuggestion = nil
                        }
                    }

                    XeTextField(title: "Price", text: $property.price)
                    XeTextEditor(title: "Description", text: $property.description)
                }.padding()
            }

            HStack(spacing: 40) {
                XeButton(title: "Submit", color: .green, isDisabled: !validatedFields()) {
                    if let selectedSuggestion {
                        viewModel.submitProperty(title: property.title,
                                                 location: selectedSuggestion,
                                                 price: property.price,
                                                 description: property.description)
                    }
                }
                XeButton(title: "Clear", color: .red) {
                    clearFields()
                }
            }
            .padding(.horizontal, DesignMetric.extraLarge)
        }
    }

    private func validatedFields() -> Bool {
        property.mandatoriesValidated() && selectedSuggestion != nil
    }

    private func clearFields() {
        property.reset()
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
