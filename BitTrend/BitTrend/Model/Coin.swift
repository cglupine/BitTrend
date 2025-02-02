//
//  Coin.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct Coin: Identifiable, Decodable {
    
    let id: String
    let symbol: String
    let name: String
}
