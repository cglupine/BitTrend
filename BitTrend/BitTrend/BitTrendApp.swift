//
//  BitTrendApp.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

@main
struct BitTrendApp: App {
    
    @StateObject private var store = CoinStore(repository: MockCoinRepository())
    
    var body: some Scene {
        
        WindowGroup {
            CoinsListView()
        }
        .environmentObject(self.store)
    }
}
