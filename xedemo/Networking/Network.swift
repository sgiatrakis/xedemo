//
//  Network.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Alamofire

protocol NetworkAPI {
    func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion]
}

class Network: NetworkAPI {

    private let networkManager: NetworkManagerAPI

    init(networkManager: NetworkManagerAPI) {
        self.networkManager = networkManager
    }

    func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion] {
        let data = try await networkManager.performAsyncWithRequestBuilder(
            RequstBuilder.fetchAutoCompleteSuggestions(input: input))
        let response = try JSONDecoder().decode([AutoCompleteSuggestionResponse].self, from: data)
        return AutoCompleteSuggestionMapper.map(response)
    }
}
