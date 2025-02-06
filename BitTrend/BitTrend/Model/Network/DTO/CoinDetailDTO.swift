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
    
    func description(languageCode: String?) -> String? {
        
        guard let languageCode else {
            
            return nil
        }
        
        return self.description[languageCode]
    }
    
    func homePageURLString() -> String? {
        
         self.links.homepage.first
    }
}
