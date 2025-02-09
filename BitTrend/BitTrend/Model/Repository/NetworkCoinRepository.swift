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
    
    func fetchMarketCoins(count: Int, currencyCode: String, languageCode: String, precision: Int) async throws -> [CoinListMarketDTO] {
        
        let request = CoinListMarketRequest(query: .init(
            vs_currency: currencyCode,
            per_page: count,
            locale: languageCode,
            precision: "\(precision)"))
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response
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
    
    func fetchCharts(for coinId: String, currencyCode: String, days: Int, precision: Int) async throws -> [ChartDTO.Entry] {
        
        let request = CoinHistoricalChartDataRequest(
            id: coinId,
            query: .init(vs_currency: currencyCode, days: days, precision: precision))
        let loader = NetworkRequestLoader(request: request,
                                          session: self.session,
                                          reachabilityService: self.reachabilityService)
        self.pendingLoader = loader
        
        let response = try await loader.loadResponse()
        self.pendingLoader = nil
        
        return response.prices
    }
}
