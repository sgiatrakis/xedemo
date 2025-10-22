//
//  LoadingState.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Foundation

enum EventState<T: Equatable>: Equatable {
    case initial
    case success(T)
}
