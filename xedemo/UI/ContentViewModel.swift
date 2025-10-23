//
//  ContentViewModel.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    private let service: ServiceAPI
    private let cacheManager: AutoCompleteCacheManagerAPI

    @Published var state: EventState<String> = .initial

    init(service: ServiceAPI = di()!,
         cacheManager: AutoCompleteCacheManagerAPI = di()!) {
        self.service = service
        self.cacheManager = cacheManager
    }

    func submitProperty(title: String,
                        location: AutoCompleteSuggestion,
                        price: String?,
                        description: String?) {
        if let jsonString = location.asJSONFormat(title: title,
                                            price: price,
                                            description: description) {
            state = .success(jsonString)
            // Remove json after 3 secs, Revert Sticky Buttons and Clear all fields
            Task {
                await DelayHelper.delay(3)
                state = .initial
            }
        } else {
            print("Debug Demo Error \(#function)")
        }
    }

    func fetchAutoCompleteSuggestions(input: String) async -> [AutoCompleteSuggestion] {
        // First, we try getting cached xe properties, if any.
        if let cached = cacheManager.getCachedSuggestions(for: input), !cached.isEmpty {
            return cached
        }

        do {
            let autoCompleteSuggestion = try await service.fetchAutoCompleteSuggestions(input: input)
            cacheManager.cacheSuggestions(autoCompleteSuggestion, for: input)
            return autoCompleteSuggestion
        } catch {
            print("Debug Demo Error: \(error)")
            return []
        }
    }

}
