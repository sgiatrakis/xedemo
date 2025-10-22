//
//  AutocCmpleteSuggestionResponse.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

public struct AutoCompleteSuggestionResponse: Decodable {
    public var placeId: String = ""
    public var mainText: String = ""
    public var secondaryText: String = ""

    private enum CodingKeys: String, CodingKey {
        case placeId
        case mainText
        case secondaryText
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        placeId = try container.decode(String.self, forKey: .placeId)
        mainText = try container.decode(String.self, forKey: .mainText)
        secondaryText = try container.decode(String.self, forKey: .secondaryText)
    }
}
