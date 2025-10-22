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
    private let cacheManager: AutoCompleteCacheManager

    @Published var state: EventState<String> = .initial
    @Published var cachedSuggestions: [AutoCompleteSuggestion] = []

    init(service: ServiceAPI = di()!,
         cacheManager: AutoCompleteCacheManager = di()!) {
        self.service = service
        self.cacheManager = cacheManager
    }

    func submitProperty(title: String,
                        location: AutoCompleteSuggestion,
                        price: String?,
                        description: String?) {
        if let jsonString = createJSONString(title: title,
                                             location: location,
                                             price: price,
                                             description: description) {
            state = .success(jsonString)
            // Remove json after 3 secs, Revert Sticky Buttons and Clear all fields
            Task {
                await DelayHelper.delay(3)
                state = .initial
            }
        }
    }

    func fetchAutoCompleteSuggestions(input: String) async -> [AutoCompleteSuggestion] {
        // First, we try getting cached xe properties, if any.
        if let cached = cacheManager.getCachedSuggestions(for: input), !cached.isEmpty {
            self.cachedSuggestions = cached
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

extension ContentViewModel {
    func createJSONString(title: String,
                          location: AutoCompleteSuggestion,
                          price: String?,
                          description: String?) -> String? {
        let propertyDict: [String: Any] = [
            "title": title,
            "location": [
                "placeId": location.placeId,
                "mainText": location.mainText,
                "secondaryText": location.secondaryText
            ],
            "price": price ?? "",
            "description": description ?? ""
        ]

        if let data = try? JSONSerialization.data(withJSONObject: propertyDict, options: .prettyPrinted),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        }
        return nil
    }
}
