//
//  CoinViewModel.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinViewModel: Identifiable {
    
    let id: String
    let name: String
    let symbol: String
    let ranking: Int
    let thumbnailURLString: String
    
    static func bitcoin() -> Self {
        .init(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            ranking: 1,
            thumbnailURLString: "https://coin-images.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400"
        )
    }
}
