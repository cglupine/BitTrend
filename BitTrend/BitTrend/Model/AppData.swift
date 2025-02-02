//
//  AppData.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import Foundation

struct AppData {
    
    static func apiKey() -> String {
        
        Bundle.main.infoDictionary?["COIN_GECKO_API_KEY"] as? String ?? ""
    }
    
    static func baseURLString() -> String {
        
        let scheme = Bundle.main.infoDictionary?["COIN_GECKO_API_BASE_URL_SCHEME"] as? String ?? ""
        let hostname = Bundle.main.infoDictionary?["COIN_GECKO_API_BASE_URL_HOSTNAME"] as? String ?? ""
        return "\(scheme)://\(hostname)"
    }
    
    static func isMockEnabled() -> Bool {
        
        CommandLine.arguments.contains("mock_enabled")
    }
}
