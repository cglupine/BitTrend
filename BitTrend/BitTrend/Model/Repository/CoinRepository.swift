//
//  CoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

protocol CoinRepository {
    
    init(reachabilityService: ReachabilityService)
    
    func cancel()
    func fetchBitCoinRates() async throws -> RatesDTO
    func fetchCoins() async throws -> [CoinDTO]
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO
    func fetchCharts(for coinId: String) async throws -> [ChartDTO.Entry]
}
