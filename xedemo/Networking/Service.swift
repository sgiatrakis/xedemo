//
//  Service.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

protocol ServiceAPI {
    func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion]
}

class Service: ServiceAPI {
    private let network: NetworkAPI

    init(network: NetworkAPI) {
        self.network = network
    }

    func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion] {
        return try await network.fetchAutoCompleteSuggestions(input: input)
    }
}
