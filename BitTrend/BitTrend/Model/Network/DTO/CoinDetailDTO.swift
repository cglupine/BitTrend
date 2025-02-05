//
//  CoinDetailDTO.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct CoinDetailDTO: Decodable {
    
    struct Links: Decodable {
        
        let homepage: [String]
    }
    
    struct Market: Decodable {
        
        let current_price: [String: Double]
    }
    
    let description: [String: String]
    let links: Links
    let market_data: Market
    
    func toModel(languageCode: String) -> CoinDetail {
        
        .init(
            description: description[languageCode] ?? "",
            homepageURLString: links.homepage.first ?? ""
        )
    }
}
