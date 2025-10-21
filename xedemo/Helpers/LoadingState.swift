//
//  LoadingState.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import Foundation

enum LoadingState<T> {
    case initial
    case loading
    case success(T)
    case error(String)
}
