//
//  DependencyContainer.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Swinject

public class DependencyContainer {
    public static var shared: DependencyContainer = .init()

    fileprivate let container: Container = .init()

    public func register(assembly: Assembly) {
        register(assemblies: [assembly])
    }

    public func register(assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: container) }
    }

    /// Use only for unit tests
    public func unregisterAll() {
        container.removeAll()
    }
}

public func di<Service>(_ serviceType: Service.Type = Service.self) -> Service? {
    return DependencyContainer.shared.container.resolve(serviceType)
}

public func di<Service, Arg1>(_ serviceType: Service.Type = Service.self, argument: Arg1) -> Service? {
    return DependencyContainer.shared.container.resolve(serviceType, argument: argument)
}
