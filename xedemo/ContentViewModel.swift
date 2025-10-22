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

    @Published var state: LoadingState<String> = .initial

    init(service: ServiceAPI = di()!) {
        self.service = service
    }

    func submitProperty(title: String,
                        location: AutoCompleteSuggestion,
                        price: String?,
                        description: String?) {
        if let jsonString = createJSONString(title: title,
                                             location: location,
                                             price: price,
                                             description: description) {
            //            Task { @MainActor in
            //                // TODO: Add logic
            //            }
        }
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
