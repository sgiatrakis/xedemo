//
//  XeProperty.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

struct XeProperty {
    var title: String = ""
    var location: String = ""
    var price: String = ""
    var description: String = ""

    mutating func reset() {
        self = XeProperty()
    }

    func mandatoriesValidated() -> Bool {
        title.isEmpty || location.isEmpty
    }
}
