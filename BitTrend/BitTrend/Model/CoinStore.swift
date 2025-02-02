//
//  CoinStore.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class CoinStore: ObservableObject {
    
    @Published var coins: [CoinViewModel] = []
    
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        
        self.repository = repository
    }
    
    func fetchEURRate() async throws -> Double {
        
        let rates = try await self.repository.fetchBitCoinRates()
        return rates.rates["eur"]?.value ?? .zero
    }
    
    @MainActor func fetchCoins() async throws {

        let eurRate = try await self.fetchEURRate()
        let fetched = try await self.repository.fetchCoins()
            .map { $0.viewModel(eurRate: eurRate) }
        
        self.coins = Array(fetched.prefix(10))
    }
}
