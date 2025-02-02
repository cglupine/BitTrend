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
    
    @MainActor func fetchCoins() async throws {

        let fetched = try await self.repository.fetchCoins()
            .map { $0.viewModel() }
        
        self.coins = Array(fetched.prefix(10))
    }
}
