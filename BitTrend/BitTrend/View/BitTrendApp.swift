//
//  BitTrendApp.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

@main
struct BitTrendApp: App {
    
    @State private var store = CoinStore(repository: CoinRepositoryFactory.createRepository())
    
    var body: some Scene {
        
        WindowGroup {
            CoinsListView()
        }
        .environment(self.store)
    }
}
