//
//  CoinsListView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

extension CoinsListView {
    
    enum ViewStatus {
        
        case loading, completed, failed
    }
}

struct CoinsListView: View {
    
    @Environment(CoinStore.self) private var store: CoinStore
    @State private var state: ViewStatus = .loading
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                switch self.state {
                    
                case .loading:
                    ProgressView(LK.loading.rawValue)
                    
                case .failed:
                    ErrorView(action: self.fetchCoins)
                    
                case .completed:
                    List(self.store.coins) { coin in
                        
                        NavigationLink(destination: CoinDetailView(coin: coin)) {
                            
                            CoinRowView(coin: coin)
                        }
                    }
                }
            }
            .navigationTitle(LK.appName.rawValue)
        }
        }
        .onAppear(perform: self.fetchCoins)
    }
    
    //MARK: - PRIVATE
    
    private func fetchCoins() {
        
        self.state = .loading
        
        Task {
            do {
                try await self.store.fetchCoins()
                self.state = .completed
                
            } catch {
                
                self.state = .failed
            }
        }
    }
}

#Preview {
    CoinsListView()
        .environment(CoinStore(repository: MockCoinRepository(reachabilityService: MockReachabilityService())))
}
