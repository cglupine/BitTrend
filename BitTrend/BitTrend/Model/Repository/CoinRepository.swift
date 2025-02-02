//
//  CoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

protocol CoinRepository {
    
    func fetchBitCoinRates() async throws -> RatesDTO
    func fetchCoins() async throws -> [CoinDTO]
}
