//
//  CoinDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinDTO: Decodable {
    
    struct Content: Decodable {
        
        let title: String
        let description: String
    }
    
    let id: String
    let coin_id: Int
    let symbol: String
    let name: String
    let market_cap_rank: Int
    let price_btc: Double
    let thumb: String
    let content: Content
    let slug: String
    
    func viewModel(eurRate: Double) -> CoinViewModel {
        
        .init(id: self.id,
              name: self.name,
              symbol: self.symbol,
              ranking: self.market_cap_rank,
              btcPrice: self.price_btc,
              eurPrice: self.price_btc * eurRate,
              thumbnailURLString: self.thumb)
    }
}
