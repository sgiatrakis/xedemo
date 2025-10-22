//
//  NetworkManager.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Alamofire

protocol NetworkManagerAPI {
    func performAsyncWithRequestBuilder(_ requestBuilder: RequstBuilder) async throws -> Data
}

class NetworkManager: NetworkManagerAPI {
    func performAsyncWithRequestBuilder(_ requestBuilder: RequstBuilder) async throws -> Data {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(requestBuilder).validate().responseData { response in
                if let data = response.data {
                    continuation.resume(returning: data)
                } else if let err = response.error {
                    continuation.resume(throwing: err)
                }
            }
        }
    }
}
