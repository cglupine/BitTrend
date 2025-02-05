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
     
        let store = CoinStore(repository: MockCoinRepository(
            session: NetworkSessionFactory.createEphemeral(),
            reachabilityService: MockReachabilityService()))
        #expect(store.coins.isEmpty)
        
        try await store.loadTopTenCoins()
        #expect(store.coins.count == 10)
    }
}
