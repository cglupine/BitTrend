//
//  MockCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class MockCoinRepository: CoinRepository {
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(1.5))
            
            if let path = Bundle.main.path(forResource: "coins", ofType: "json"),
               let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                
                let trend = try JSONDecoder().decode(TrendDTO.self, from: data)
                return trend.coins.map { $0.item }
            }
            
            return []
        }
        
        return try await task.value
    }
}
