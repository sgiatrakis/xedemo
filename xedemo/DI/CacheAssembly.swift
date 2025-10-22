//
//  CacheAssembly.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Swinject
import SwiftData

struct CacheAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ModelContainer.self) { _ in
            // swiftlint:disable:next force_try
            try! ModelContainer(for: AutoCompleteCacheItem.self)
        }.inObjectScope(.container)

        container.register(ModelContext.self) { resolver in
            let modelContainer = resolver.resolve(ModelContainer.self)!
            return ModelContext(modelContainer)
        }.inObjectScope(.container)

        container.register(AutoCompleteCacheManager.self) { resolver in
            let context = resolver.resolve(ModelContext.self)!
            return AutoCompleteCacheManager(context: context)
        }.inObjectScope(.container)

        container.register(AutoCompleteCacheManagerAPI.self) { resolver in
            resolver.resolve(AutoCompleteCacheManager.self)!
        }.inObjectScope(.container)
    }
}
