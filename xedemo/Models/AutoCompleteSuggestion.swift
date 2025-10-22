//
//  AutoCompleteSuggestion.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

struct AutoCompleteSuggestion: Codable, Identifiable, Hashable {
    var placeId: String
    var mainText: String
    var secondaryText: String

    var id: String {
        placeId
    }

    var displayText: String {
        mainText + ", " + secondaryText
    }
}
