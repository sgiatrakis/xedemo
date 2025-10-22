//
//  NetworkManagerAssembly.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Swinject

struct NetworkManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkManagerAPI.self) {_ in
            return NetworkManager()
        }
    }
}
