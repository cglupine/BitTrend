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
}
