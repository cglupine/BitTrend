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
    let btcPrice: Double
    let eurPrice: Double
    let thumbnailURLString: String
    
    static func mockBitCoin() -> Self {
        .init(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            ranking: 1,
            btcPrice: 1,
            eurPrice: 95832.34,
            thumbnailURLString: "https://coin-images.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400"
        )
    }
}
