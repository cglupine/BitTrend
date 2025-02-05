//
//  CoinDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinDTO: Decodable {
    
    struct Data: Decodable {
        
        let price_change_percentage_24h: [String: Double]
    }
    
    let id: String
    let coin_id: Int
    let symbol: String
    let name: String
    let market_cap_rank: Int
    let price_btc: Double
    let thumb: String
    let large: String
    let data: Data
    
    func toModel(eurRate: Double, percentageChangeSymbol: String) -> Coin {
        
        .init(id: self.id,
              name: self.name,
              symbol: self.symbol,
              rank: self.market_cap_rank,
              eurPrice: self.price_btc * eurRate,
              percentageChange: self.data.price_change_percentage_24h[percentageChangeSymbol] ?? .zero,
              thumbnailURLString: self.thumb,
              largeImageURLString: self.large)
    }
}
