//
//  NetworkCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class NetworkCoinRepository: CoinRepository {
    
    func fetchBitCoinRates() async throws -> RatesDTO {
        
        .init(rates: [:])
    }
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        return []
    }
    
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO {
        
        throw NSError(domain: "network", code: -1)
    }
    
}
