//
//  CoinViewModel.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinViewModel: Identifiable, Equatable{
    
    let id: String
    let name: String
    let symbol: String
    let eurPrice: Double
    let thumbnailURLString: String
    let largeImageURLString: String
    
    static func == (lhs: CoinViewModel, rhs: CoinViewModel) -> Bool {
        
        lhs.id == rhs.id
    }
    
    static func mockBitCoin() -> Self {
        .init(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "BTC",
            eurPrice: 95832.34,
            thumbnailURLString: "https://coin-images.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400",
            largeImageURLString: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
        )
    }
}
