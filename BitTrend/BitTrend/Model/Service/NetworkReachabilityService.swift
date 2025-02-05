//
//  NetworkReachabilityService.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation
import Network

class NetworkReachabilityService: ReachabilityService {
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    var isInternetAccessible: Bool {
        
        self.monitor.currentPath.status == .satisfied
    }
    
    deinit {
        
        self.monitor.cancel()
    }

    func start() {
    
        self.monitor.start(queue: self.queue)
    }
}
