//
//  ChartDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct ChartDTO: Decodable {
    
    struct Entry: Decodable {
        
        let date: Date
        let price: Double
        
        func toViewModel() -> CoinDetailViewModel.ChartData {
            
            .init(date: self.date, amount: self.price)
        }
    }
    
    let prices: [Entry]
    
    enum CodingKeys: CodingKey {
        
        case prices
    }
    
    init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let values = try container.decode([[Double]].self, forKey: .prices)
        
        self.prices = values.compactMap { array in
            
            guard let dateValue = array.first,
                  let amount = array.last else {
                
                return nil
            }
            
            return Entry(date: Date(timeIntervalSince1970: dateValue / 1000), price: amount)
        }
    }
}
