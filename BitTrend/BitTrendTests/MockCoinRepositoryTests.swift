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
        
        self.repository = .init(reachabilityService: MockReachabilityService())
    }

    @Test(.serialized, arguments: [
        TrendingSearchListRequest.Outcome.success,
        TrendingSearchListRequest.Outcome.empty,
        TrendingSearchListRequest.Outcome.failure
    ]) func shouldFetchCoins(outcome: TrendingSearchListRequest.Outcome) async throws {
        
        TrendingSearchListRequest.iMockURLProtocol.outcome = outcome

        switch outcome {
            
        case .success:
            let coins = try await self.repository.fetchCoins()
            #expect(coins.count == 15)
            
        case .empty:
            let coins = try await self.repository.fetchCoins()
            #expect(coins.isEmpty)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchCoins()
            }
        }
    }
    
    @Test(.serialized, arguments: [
        BTCExchangeRatesRequest.Outcome.success,
        BTCExchangeRatesRequest.Outcome.empty,
        BTCExchangeRatesRequest.Outcome.failure
    ]) func shouldFetchRates(outcome: BTCExchangeRatesRequest.Outcome) async throws {
        
        BTCExchangeRatesRequest.iMockURLProtocol.outcome = outcome
        
        switch outcome {
            
        case .success:
            let rates = try await self.repository.fetchBitCoinRates()
            #expect(!rates.rates.isEmpty)
            
        case .empty:
            let rates = try await self.repository.fetchBitCoinRates()
            #expect(rates.rates.isEmpty)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchBitCoinRates()
            }
        }
    }
    
    @Test(.serialized, arguments: [
        CoinDataRequest.Outcome.success,
        CoinDataRequest.Outcome.failure
    ]) func shouldFetchCoinDetails(outcome: CoinDataRequest.Outcome) async throws {
        
        CoinDataRequest.iMockURLProtocol.outcome = outcome
        
        switch outcome {
            
        case .success:
            let details = try await self.repository.fetchDetails(for: "bitcoin")
            #expect(details.description["en"] != nil)
            #expect(!details.links.homepage.isEmpty)
            #expect(details.market_data.current_price["eur"] != nil)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchDetails(for: "bitcoin")
            }
        }
    }
    
    @Test(.serialized, arguments: [
        CoinHistoricalChartDataRequest.Outcome.success,
        CoinHistoricalChartDataRequest.Outcome.empty,
        CoinHistoricalChartDataRequest.Outcome.failure
    ]) func shouldFetchChartData(outcome: CoinHistoricalChartDataRequest.Outcome) async throws {
        
        CoinHistoricalChartDataRequest.iMockURLProtocol.outcome = outcome
        
        switch outcome {
            
        case .success:
            let data = try await self.repository.fetchCharts(for: "bitcoin", currencyCode: "eur", days: 7, precision: 2)
            #expect(!data.isEmpty)
            
        case .empty:
            let data = try await self.repository.fetchCharts(for: "bitcoin", currencyCode: "eur", days: 7, precision: 2)
            #expect(data.isEmpty)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchCharts(for: "bitcoin", currencyCode: "eur", days: 7, precision: 2)
            }
        }
    }
}
