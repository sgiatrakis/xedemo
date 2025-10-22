//
//  ContentViewModel.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Combine

class ContentViewModel: ObservableObject {
    private let service: ServiceAPI

    @Published var state: LoadingState<String> = .initial

    init(service: ServiceAPI = di()!) {
        self.service = service
    }

    func submitProperty(title: String,
                        location: String,
                        price: String?,
                        description: String?) {
    }

    func fetchAutoCompleteSuggestions(input: String) async -> [AutoCompleteSuggestion] {
        do {
            let autoCompleteSuggestion = try await service.fetchAutoCompleteSuggestions(input: input)
            return autoCompleteSuggestion
        } catch {
            print("Debug Demo Error: \(error)")
            return []
        }
    }

}
