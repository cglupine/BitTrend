//
//  MockCoinRepositoryTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

struct MockCoinRepositoryTests {
    
    private let repository: MockCoinRepository
    
    init() {
        
        self.repository = .init(session: NetworkSessionFactory.createEphemeral(),
                                reachabilityService: MockReachabilityService())
    }

    @Test func shouldFetchCoins() async throws {
        
        let coins = try await self.repository.fetchCoins()
        #expect(coins.count == 15)
    }
    
    @Test func shouldFetchRates() async throws {
        
        let rates = try await self.repository.fetchBitCoinRates()
        #expect(!rates.rates.isEmpty)
    }
    
    @Test func shouldFetchCoinDetails() async throws {
        
        let details = try await self.repository.fetchDetails(for: "bitcoin")
        #expect(details.description["en"] != nil)
        #expect(!details.links.homepage.isEmpty)
        #expect(details.market_data.current_price["eur"] != nil)
    }
    
    @Test func shouldFetchChartData() async throws {
        
        let data = try await self.repository.fetchCharts(for: "bitcoin")
        #expect(!data.isEmpty)
    }
}
