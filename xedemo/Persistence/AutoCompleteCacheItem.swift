//
//  AutoCompleteCacheItem.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import SwiftData
import Foundation

@Model
final class AutoCompleteCacheItem {
    @Attribute(.unique) var key: String
    var jsonData: Data
    var timestamp: Date = Date()

    init(key: String, suggestions: [AutoCompleteSuggestion]) {
        self.key = key
        self.timestamp = Date()
        if let data = try? JSONEncoder().encode(suggestions) {
            self.jsonData = data
        } else {
            self.jsonData = Data()
        }
    }

    func getSuggestions() -> [AutoCompleteSuggestion] {
        (try? JSONDecoder().decode([AutoCompleteSuggestion].self, from: jsonData)) ?? []
    }

    func setSuggestions(_ suggestions: [AutoCompleteSuggestion]) {
        if let data = try? JSONEncoder().encode(suggestions) {
            self.jsonData = data
            self.timestamp = Date()
        }
    }
}
