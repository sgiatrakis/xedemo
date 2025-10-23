//
//  Ext+View.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 23/10/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}
