//
//  ValidatedFields.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Foundation

struct FieldError {
    let field: FieldKey
    let message: String
}

enum FieldKey: String {
    case title
    case location
}
