//
//  CoinStoreTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

struct CoinStoreTests {

    @Test func shouldFetchTopTenCoins() async throws {
     
        let store = CoinStore(repository: MockCoinRepository())
        #expect(store.coins.isEmpty)
        
        try await store.fetchCoins()
        #expect(store.coins.count == 10)
    }
}
