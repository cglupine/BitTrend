//
//  NetworkCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class NetworkCoinRepository: CoinRepository {
final class NetworkCoinRepository: CoinRepository {
    
    private let reachabilityService: ReachabilityService
    private let session = NetworkSessionFactory.create(withConfiguration: .default)
    
    init(reachabilityService: ReachabilityService) {
        
        self.reachabilityService = reachabilityService
    }
    
    func cancel() {
        
    }
    
    func fetchBitCoinRates() async throws -> RatesDTO {
        
        .init(rates: [:])
    }
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        return []
    }
    
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO {
        
        throw NSError(domain: "network", code: -1)
    }
    
    func fetchCharts(for coinId: String) async throws -> [ChartDTO.Entry] {
        
        return []
    }
}
