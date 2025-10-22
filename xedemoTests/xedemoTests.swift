//
//  xedemoTests.swift
//  xedemoTests
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import XCTest
@testable import xedemo

final class xedemoTests: XCTestCase {

    private var testComponents: TestComponents?

    typealias TestComponents = (
        viewModel: ContentViewModel,
        api: StubServiceAPI
    )

    override func setUp() {
        testComponents = prepareTestComponents()
    }

    private func prepareTestComponents() -> TestComponents {
        let api = StubServiceAPI()
        let cache = StubCacheManager()
        let viewModel = ContentViewModel(service: api, cacheManager: cache)
        return (viewModel, api)
    }
    
    func test_fetchAutoCompleteSuggestions() async {
        let result = await testComponents?.viewModel.fetchAutoCompleteSuggestions(input: "Ath")
        await MainActor.run {
            XCTAssertEqual(result?.first?.placeId, "123")
            XCTAssertEqual(result?.first?.mainText, "Athens")
            XCTAssertEqual(result?.first?.secondaryText, "GR")
        }
    }

}

extension xedemoTests {
    class StubServiceAPI: ServiceAPI {
        var fetchAutoCompleteSuggestionResult: Result<[AutoCompleteSuggestion], Error> = .success([AutoCompleteSuggestion(placeId: "123", mainText: "Athens", secondaryText: "GR")])
        
        func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion] {
            try fetchAutoCompleteSuggestionResult.get()
        }

    }
    
    class StubCacheManager: AutoCompleteCacheManagerAPI {
        func getCachedSuggestions(for key: String) -> [AutoCompleteSuggestion]? {
            return nil
        }
        
        func cacheSuggestions(_ suggestions: [AutoCompleteSuggestion], for key: String) {
            // No needed
        }
    }
}
