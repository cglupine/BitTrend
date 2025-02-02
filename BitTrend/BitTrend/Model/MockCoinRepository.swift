//
//  MockCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class MockCoinRepository: CoinRepository {
    
    func fetchCoins() async throws -> [Coin] {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(1.5))
            
            if let path = Bundle.main.path(forResource: "coins", ofType: "json"),
               let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                
                return try JSONDecoder().decode([Coin].self, from: data)
            }
            
            return []
        }
        
        return try await task.value
    }
}
