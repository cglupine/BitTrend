//
//  CoinStoreTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

@Suite(.serialized) struct CoinStoreTests {
    
    private let store: CoinStore
    
    init () {
        
        BTCExchangeRatesRequest.iMockURLProtocol.outcome = .success
        TrendingSearchListRequest.iMockURLProtocol.outcome = .success
        CoinDataRequest.iMockURLProtocol.outcome = .success
        CoinHistoricalChartDataRequest.iMockURLProtocol.outcome = .success
        
        self.store = CoinStore(repository: MockCoinRepository(
            reachabilityService: MockReachabilityService()))
    }

    @Test func shouldLoadEURRate() async throws {
        
        let rate = try await self.store.loadEURRate()
        #expect(rate > 0)
    }

    @Test func shouldLoadTopTenCoins() async throws {
     
        #expect(self.store.coins.isEmpty)
        
        try await self.store.loadTopTenCoins()
        #expect(self.store.coins.count == 10)
    }
        
    @Test func shouldLoadDetailsTillLastWeek() async throws {
        
        let coin = Coin.mockBitCoin()
        let details = try await self.store.loadDetailsTillLastWeek(forCoin: coin)
        #expect(!details.description.isEmpty)
        #expect(!details.homepageURLString.isEmpty)
        
        let chardData = try #require(details.chartData)
        #expect(!chardData.isEmpty)
    }
}
