//
//  TrendDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct TrendDTO: Decodable {
    
    struct CoinItem: Decodable {
        
        let item: CoinDTO
    }
    
    let coins: [CoinItem]
}
