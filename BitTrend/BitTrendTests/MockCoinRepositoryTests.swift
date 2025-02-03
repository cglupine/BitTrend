//
//  MockCoinRepositoryTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

struct MockCoinRepositoryTests {

    @Test func shouldFetchCoins() async throws {
        
        let repository = MockCoinRepository()
        let coins = try await repository.fetchCoins()
        #expect(coins.count == 15)
    }
    
    @Test func shouldFetchRates() async throws {
        
        let repository = MockCoinRepository()
        let rates = try await repository.fetchBitCoinRates()
        #expect(!rates.rates.isEmpty)
    }
    
    @Test func shouldFetchCoinDetails() async throws {
        
        let repository = MockCoinRepository()
        let details = try await repository.fetchDetails(for: "bitcoin")
        #expect(details.description["en"] != nil)
        #expect(!details.links.homepage.isEmpty)
        #expect(details.market_data.current_price["eur"] != nil)
    }
}
