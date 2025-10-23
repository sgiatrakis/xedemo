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

extension AutoCompleteSuggestion {
    func asJSONFormat(title: String,
                      price: String?,
                      description: String?) -> String? {
        let propertyDict: [String: Any] = [
            "title": title,
            "location": [
                "placeId": self.placeId,
                "mainText": self.mainText,
                "secondaryText": self.secondaryText
            ],
            "price": price ?? "",
            "description": description ?? ""
        ]

        if let data = try? JSONSerialization.data(withJSONObject: propertyDict, options: .prettyPrinted),
           let jsonString = String(data: data, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    }
}
