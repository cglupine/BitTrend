//
//  Coin.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct Coin: Identifiable, Equatable {
    
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let eurPrice: Double
    let percentageChange: Double
    let thumbnailURLString: String
    let largeImageURLString: String
    
    static func == (lhs: Coin, rhs: Coin) -> Bool {
        
        lhs.id == rhs.id
    }
    
    static func mockBitCoin() -> Self {
        .init(
            id: UUID().uuidString,
            name: "Bitcoin",
            symbol: "BTC",
            rank: 1,
            eurPrice: 95832.34,
            percentageChange: -2.38807017432102,
            thumbnailURLString: "https://coin-images.coingecko.com/coins/images/1/standard/bitcoin.png?1696501400",
            largeImageURLString: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
        )
    }
}

extension Array where Element == Coin {
    
    static func skeleton(size: Int) -> [Coin] {
        
        (0...size).map { _ in .mockBitCoin() }
    }
}
