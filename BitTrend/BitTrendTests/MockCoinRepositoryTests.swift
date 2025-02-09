//
//  MockCoinRepositoryTests.swift
//  BitTrendTests
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Testing
@testable import BitTrend

@Suite(.serialized) struct MockCoinRepositoryTests {
    
    private let repository: MockCoinRepository
    
    init() {
        
        self.repository = .init(reachabilityService: MockReachabilityService())
    }

    @Test(arguments: [
        CoinListMarketRequest.Outcome.success,
        CoinListMarketRequest.Outcome.empty,
        CoinListMarketRequest.Outcome.failure
    ]) func shouldFetchCoins(outcome: CoinListMarketRequest.Outcome) async throws {
        
        CoinListMarketRequest.iMockURLProtocol.outcome = outcome

        switch outcome {
            
        case .success:
            let coins = try await self.repository.fetchMarketCoins(
                count: 10, currencyCode: "eur", languageCode: "en", precision: 2)
            #expect(coins.count == 10)
            
        case .empty:
            let coins = try await self.repository.fetchMarketCoins(
                count: 10, currencyCode: "eur", languageCode: "en", precision: 2)
            #expect(coins.isEmpty)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchMarketCoins(
                    count: 10, currencyCode: "eur", languageCode: "en", precision: 2)
            }
        }
    }
    
    @Test(arguments: [
        CoinDataRequest.Outcome.success,
        CoinDataRequest.Outcome.failure
    ]) func shouldFetchCoinDetails(outcome: CoinDataRequest.Outcome) async throws {
        
        CoinDataRequest.iMockURLProtocol.outcome = outcome
        
        switch outcome {
            
        case .success:
            let details = try await self.repository.fetchDetails(for: "bitcoin")
            #expect(details.description["en"] != nil)
            #expect(!details.links.homepage.isEmpty)
            
        case .failure:
            await #expect(throws: (any Error).self) {
                try await self.repository.fetchDetails(for: "bitcoin")
            }
        }
    }
    
    @Test(arguments: [
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
