//
//  CoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

protocol CoinRepository {
    
    func cancel()
    func fetchMarketCoins(count: Int, currencyCode: String, languageCode: String, precision: Int) async throws -> [CoinListMarketDTO]
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO
    func fetchCharts(for coinId: String, currencyCode: String, days: Int, precision: Int) async throws -> [ChartDTO.Entry]
}
