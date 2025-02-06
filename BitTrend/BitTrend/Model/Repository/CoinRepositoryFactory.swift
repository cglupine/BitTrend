//
//  CoinRepositoryFactory.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 05/02/25.
//

import Foundation

struct CoinRepositoryFactory {
    
    static func createRepository() -> CoinRepository {
        
        let reachabilityService = ReachabilityServiceFactory.createReachabilityService()
        
        if AppData.isMockEnabled() {
        
            return MockCoinRepository(reachabilityService: reachabilityService)
        }
        
        let session = NetworkSessionFactory.create()
        return NetworkCoinRepository(session: session, reachabilityService: reachabilityService)
    }
}
