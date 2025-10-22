//
//  AutocompleteSuggestionMapper.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

enum AutoCompleteSuggestionMapper {
    static func map(_ response: [AutoCompleteSuggestionResponse]) -> [AutoCompleteSuggestion] {
        response.map {
            AutoCompleteSuggestion(
                placeId: $0.placeId,
                mainText: $0.mainText,
                secondaryText: $0.secondaryText
            )
        }
    }
}
