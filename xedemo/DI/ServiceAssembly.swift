//
//  ServiceAssembly.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Swinject

struct ServiceAssembly: Assembly {
    func assemble(container: Container) {
        // swiftlint:disable:next identifier_name
        container.register(ServiceAPI.self) { r in
            let networkManager = r.resolve(NetworkManagerAPI.self)!
            return ServiceAPIFactory.create(networkManager: networkManager)
        }
    }
}
