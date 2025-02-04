//
//  MockCoinRepository.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

class MockCoinRepository: CoinRepository {
    
    func fetchBitCoinRates() async throws -> RatesDTO {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(0.3))
            
            if let data = self.loadJSONFileData(name: "rates") {
                
                return try JSONDecoder().decode(RatesDTO.self, from: data)
            }
            
            return RatesDTO.empty()
        }
        
        return try await task.value
    }
    
    func fetchCoins() async throws -> [CoinDTO] {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(1))
            
            if let data = self.loadJSONFileData(name: "coins") {
             
                let trend = try JSONDecoder().decode(TrendDTO.self, from: data)
                return trend.coins.map { $0.item }
            }
            
            return []
        }
        
        return try await task.value
    }
    
    func fetchDetails(for coinId: String) async throws -> CoinDetailDTO {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(0.3))
            
            if let data = self.loadJSONFileData(name: "data") {
             
                return try JSONDecoder().decode(CoinDetailDTO.self, from: data)
            }
            
            throw NSError(domain: "network", code: -1)
        }
        
        return try await task.value
    }
    
    func fetchCharts(for coinId: String) async throws -> [ChartDTO.Entry] {
        
        let task = Task {
            
            /// simulate network request loading time
            try await Task.sleep(for: .seconds(0.5))
            
            if let data = self.loadJSONFileData(name: "chart") {
             
                let chart = try JSONDecoder().decode(ChartDTO.self, from: data)
                return chart.prices
            }
            
            return []
        }
        
        return try await task.value
    }
    
    //MARK: - PRIVATE
    
    private func loadJSONFileData(name: String) -> Data? {
        
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
           
            return try? Data(contentsOf: URL(fileURLWithPath: path))
        }
        
        return nil
    }
}
