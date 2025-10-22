//
//  AutoCompleteCacheManager.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import SwiftData
import Foundation

protocol AutoCompleteCacheManagerAPI {
    func getCachedSuggestions(for key: String) -> [AutoCompleteSuggestion]?
    func cacheSuggestions(_ suggestions: [AutoCompleteSuggestion], for key: String)
}

final class AutoCompleteCacheManager: AutoCompleteCacheManagerAPI {

    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Fetch cached suggestions
    func getCachedSuggestions(for key: String) -> [AutoCompleteSuggestion]? {
        do {
            let items = try context.fetch(
                FetchDescriptor<AutoCompleteCacheItem>(predicate: #Predicate { $0.key == key })
            )
            return items.first?.getSuggestions()
        } catch {
            print("Cache fetch error: \(error)")
            return nil
        }
    }

    // MARK: - Cache new suggestions
    func cacheSuggestions(_ suggestions: [AutoCompleteSuggestion], for key: String) {
        do {
            if let existing = try context.fetch(
                FetchDescriptor<AutoCompleteCacheItem>(predicate: #Predicate { $0.key == key })
            ).first {
                existing.setSuggestions(suggestions)
            } else {
                let newItem = AutoCompleteCacheItem(key: key, suggestions: suggestions)
                context.insert(newItem)
            }
        } catch {
            print("Cache insert error: \(error)")
        }
    }
}
