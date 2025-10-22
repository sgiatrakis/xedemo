//
//  RequestBuilder.swift
//  xedemo
//
//  Created by Lysimachos Giatrakis on 22/10/25.
//

import Foundation
import Alamofire

enum RequstBuilder: URLRequestConvertible {
    case fetchAutoCompleteSuggestions(input: String)

    private var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    private var baseURL: String {
        return "https://oapaiqtgkr6wfbum252tswprwa0ausnb.lambda-url.eu-central-1.on.aws"
    }

    private var httpMethod: HTTPMethod {
        return .get
    }

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = "/"
        switch self {
        case .fetchAutoCompleteSuggestions(let input):
            components.queryItems = [
                URLQueryItem(name: "input", value: input)
            ]
        }
        guard let url = components.url else {
            throw AFError.invalidURL(url: baseURL)
        }
        var request = URLRequest(url: url)
        request.method = httpMethod
        return request
    }
}
