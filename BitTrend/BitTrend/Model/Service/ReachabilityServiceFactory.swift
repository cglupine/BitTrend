//
//  ReachabilityServiceFactory.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 05/02/25.
//

import Foundation

struct ReachabilityServiceFactory {
    
    static func createReachabilityService() -> ReachabilityService {
        
        if AppData.isMockEnabled() {
            
            return MockReachabilityService()
        }
        
        let service = NetworkReachabilityService()
        service.start()
        
        return service
    }
}
