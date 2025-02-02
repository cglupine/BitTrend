//
//  CoinDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinDTO: Decodable {
    
    let id: String
    let coin_id: Int
    let symbol: String
    let name: String
    let market_cap_rank: Int
    let thumb: String
    
    func viewModel() -> CoinViewModel {
        
        .init(id: self.id,
              name: self.name,
              symbol: self.symbol,
              ranking: self.market_cap_rank,
              thumbnailURLString: self.thumb)
    }
}
