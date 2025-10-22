//
//  ServiceAPIFactory.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation

enum ServiceAPIFactory {
    static func create(networkManager: NetworkManagerAPI) -> Service {
        let networkAPI = Network(networkManager: networkManager)
        return Service(network: networkAPI)
    }
}
