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
    
    func toViewModel(locale: Locale) -> CoinDetailViewModel {
        
        .init(
            description: description[locale.language.languageCode?.identifier ?? "en"] ?? "",
            homepageURLString: links.homepage.first ?? ""
        )
    }
}
