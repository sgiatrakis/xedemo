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
        Task { @MainActor in
            do {
                let data = try await service.fetchAutoCompleteSuggestions(input: "nafplio")
                print("Debug Data: \(data)")
            } catch let error {
                print("Debug Demo: \(error)")
            }
        }
    }
}
