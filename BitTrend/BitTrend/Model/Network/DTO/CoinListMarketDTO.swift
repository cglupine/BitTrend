//
//  CoinListMarketDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import Foundation

struct CoinListMarketDTO: Decodable {
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    let current_price: Double
    let market_cap: Double
    let market_cap_rank: Int
    let price_change_percentage_24h: Double
}
