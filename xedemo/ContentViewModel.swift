//
//  ContentViewModel.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Combine

class ContentViewModel: ObservableObject {

    @Published var state: LoadingState<String> = .initial

    func submitProperty(title: String,
                        location: String,
                        price: String?,
                        description: String?) {

    }
}
