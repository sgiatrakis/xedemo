//
//  xedemoTests.swift
//  xedemoTests
//
//  Created by Lysimachos Giatrakis on 21/10/25.
//

import XCTest
@testable import xedemo

final class xedemoTests: XCTestCase {

    private var testComponentsLive: TestComponents?
    private var testComponentsCached: TestComponents?

    typealias TestComponents = (
        viewModel: ContentViewModel,
        api: StubServiceAPI
    )

    override func setUp() {
        testComponentsLive = prepareTestComponentsLiveResults()
        testComponentsCached = prepareTestComponentsCachedResults()
    }

    private func prepareTestComponentsLiveResults() -> TestComponents {
        let api = StubServiceAPI()
        let cache = StubCacheManagerAPINoResults()
        let viewModel = ContentViewModel(service: api, cacheManager: cache)
        return (viewModel, api)
    }

    private func prepareTestComponentsCachedResults() -> TestComponents {
        let api = StubServiceAPI()
        let cache = StubCacheManagerAPI()
        let viewModel = ContentViewModel(service: api, cacheManager: cache)
        return (viewModel, api)
    }

    func test_fetchAutoCompleteSuggestionsLive_Success() async {
        let result = await testComponentsLive?.viewModel.fetchAutoCompleteSuggestions(input: "Ath")
        await MainActor.run {
            // Live Results from StubServiceAPI
            XCTAssertEqual(result?.first?.placeId, "123")
            XCTAssertEqual(result?.first?.mainText, "Athens")
            XCTAssertEqual(result?.first?.secondaryText, "GR")
            // Nothing from Cache, as we mocked StubCacheManagerAPINoResults
            XCTAssertNotEqual(result?.first?.placeId, "789")
            XCTAssertNotEqual(result?.first?.mainText, "Heraklion")
            XCTAssertNotEqual(result?.first?.secondaryText, "Crete")
        }
    }

    func test_fetchAutoCompleteSuggestionsLive_Failure() async {
        testComponentsLive?.api.fetchAutoCompleteSuggestionResult = .failure(NSError(domain: "errorTest", code: 0))
        let result = await testComponentsLive?.viewModel.fetchAutoCompleteSuggestions(input: "Ath")
        await MainActor.run {
            if let result {
                XCTAssertTrue(result.isEmpty)
            }
        }
    }
    
    func test_fetchAutoCompleteSuggestionsCache_Success() async {
        let result = await testComponentsCached?.viewModel.fetchAutoCompleteSuggestions(input: "Ath")
        await MainActor.run {
            // No Live Results from StubServiceAPI
            XCTAssertNotEqual(result?.first?.placeId, "123")
            XCTAssertNotEqual(result?.first?.mainText, "Athens")
            XCTAssertNotEqual(result?.first?.secondaryText, "GR")
            // Instead, we have Cached Results from StubCacheManager
            XCTAssertEqual(result?.first?.placeId, "789")
            XCTAssertEqual(result?.first?.mainText, "Heraklion")
            XCTAssertEqual(result?.first?.secondaryText, "Crete")
        }
    }
}

extension xedemoTests {
    class StubServiceAPI: ServiceAPI {
        // Instead coding results once, by custom Result addition we can change during Unit test execution
        var fetchAutoCompleteSuggestionResult: Result<[AutoCompleteSuggestion], Error> = .success([AutoCompleteSuggestion(placeId: "123", mainText: "Athens", secondaryText: "GR")])
        
        func fetchAutoCompleteSuggestions(input: String) async throws -> [AutoCompleteSuggestion] {
            try fetchAutoCompleteSuggestionResult.get()
        }

    }

    class StubCacheManagerAPI: AutoCompleteCacheManagerAPI {
        func getCachedSuggestions(for key: String) -> [AutoCompleteSuggestion]? {
            [AutoCompleteSuggestion(placeId: "789", mainText: "Heraklion", secondaryText: "Crete")]
        }
        
        func cacheSuggestions(_ suggestions: [AutoCompleteSuggestion], for key: String) {
            // No needed
        }
    }

    class StubCacheManagerAPINoResults: AutoCompleteCacheManagerAPI {
        func getCachedSuggestions(for key: String) -> [AutoCompleteSuggestion]? {
            nil
        }
        
        func cacheSuggestions(_ suggestions: [AutoCompleteSuggestion], for key: String) {
            // No needed
        }
    }
}
