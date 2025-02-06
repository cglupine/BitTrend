//
//  MockCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

final class MockCoinRepository: CoinRepository {
    
    private static let delayRange = 0.1...1
    private let reachabilityService: ReachabilityService
    private var pendingLoader: CancellableNetworkRequestLoader?
    
    init(reachabilityService: ReachabilityService) {
        
        self.reachabilityService = reachabilityService
    }
    
    func cancel() {
    
        self.pendingLoader?.cancel()
    }
    
    func fetchBitCoinRates() async throws -> RatesDTO {
        
        let session = NetworkSessionFactory.createEphemeral(with: BTCExchangeRatesRequest.iMockURLProtocol.self)
        
        let request = BTCExchangeRatesRequest()
        let loader = NetworkRequestLoader(request: request,
                                          session: session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        /// simulate network request loading time
        try await Task.sleep(for: .seconds(Double.random(in: Self.delayRange)))
        
        if Task.isCancelled {
            throw CancellationError()
        }
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response
    }
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        let session = NetworkSessionFactory.createEphemeral(with: TrendingSearchListRequest.iMockURLProtocol.self)
        
        let request = TrendingSearchListRequest()
        let loader = NetworkRequestLoader(request: request,
                                          session: session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        /// simulate network request loading time
        try await Task.sleep(for: .seconds(Double.random(in: Self.delayRange)))

        if Task.isCancelled {
            throw CancellationError()
        }
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response.coins.map { $0.item }
    }
    
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO {
        
        let session = NetworkSessionFactory.createEphemeral(with: CoinDataRequest.iMockURLProtocol.self)
        
        let request = CoinDataRequest(id: coinId)
        let loader = NetworkRequestLoader(request: request,
                                          session: session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        /// simulate network request loading time
        try await Task.sleep(for: .seconds(Double.random(in: Self.delayRange)))

        if Task.isCancelled {
            throw CancellationError()
        }
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response
    }
    
    func fetchCharts(for coinId: String, currencyCode: String, days: Int, precision: Int) async throws -> [ChartDTO.Entry] {

        let session = NetworkSessionFactory.createEphemeral(with: CoinHistoricalChartDataRequest.iMockURLProtocol.self)
        
        let request = CoinHistoricalChartDataRequest(
            id: coinId,
            query: .init(vs_currency: currencyCode, days: days, precision: precision))
        let loader = NetworkRequestLoader(request: request,
                                          session: session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        /// simulate network request loading time
        try await Task.sleep(for: .seconds(Double.random(in: Self.delayRange)))

        if Task.isCancelled {
            throw CancellationError()
        }
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response.prices
    }
}
