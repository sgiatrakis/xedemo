//
//  ContentViewModel.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Combine

class ContentViewModel: ObservableObject {

    @Published var state: LoadingState<String> = .initial
    @Published private(set) var fieldValidationErrors: [FieldError] = []

    private func validateMandatoryData(title: String, location: String) -> [FieldError] {
        var errors: [FieldError] = []
        if title.isEmpty {
            errors.append(FieldError(field: .title, message: "Title is required"))
        }
        if location.isEmpty {
            errors.append(FieldError(field: .location, message: "Location is required"))
        }
        return errors
    }

    func submitProperty(title: String,
                        location: String,
                        price: String?,
                        description: String?) {
        let validationErrors = validateMandatoryData(title: title, location: location)
        guard validationErrors.isEmpty else {
            fieldValidationErrors = validationErrors
            return
        }
    }

    func clearValidation(for fieldKey: FieldKey) {
        fieldValidationErrors.removeAll { $0.field == fieldKey }
    }

}
