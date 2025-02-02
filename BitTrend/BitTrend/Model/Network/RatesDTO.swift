//
//  RatesDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct RatesDTO: Decodable {
    
    struct RateDTO: Decodable {
        
        let name: String
        let unit: String
        let value: Double
        let type: String
    }
    
    let rates: [String: RateDTO]
    
    static func empty() -> RatesDTO {
    
        .init(rates: [:])
    }
}
