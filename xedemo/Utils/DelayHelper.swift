//
//  DelayHelper.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

final class DelayHelper {
    static func delay(_ seconds: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}
