//
//  NetworkCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

final class NetworkCoinRepository: CoinRepository {
    
    private let session: URLSession
    private let reachabilityService: ReachabilityService
    private var pendingLoader: CancellableNetworkRequestLoader?
    
    init(session: URLSession, reachabilityService: ReachabilityService) {
        
        self.session = session
        self.reachabilityService = reachabilityService
    }
    
    func cancel() {
        
        self.pendingLoader?.cancel()
    }
    
    func fetchBitCoinRates() async throws -> RatesDTO {
        
        let request = BTCExchangeRatesRequest()
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response
    }
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        let request = TrendingSearchListRequest()
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response.coins.map { $0.item }
    }
    
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO {
        
        let request = CoinDataRequest(id: coinId)
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response
    }
    
    func fetchCharts(for coinId: String) async throws -> [ChartDTO.Entry] {
        
        let request = CoinHistoricalChartDataRequest(
            id: coinId,
            query: .init(vs_currency: "eur", days: 7, precision: 2))
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response.prices
    }
}
