//
//  CoinsListView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct CoinsListView: View {
    
    @EnvironmentObject private var store: CoinStore
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
        .task {
            self.fetchCoins()
        }
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

extension CoinsListView {
    
    enum ViewStatus {
        
        case loading, completed, failed
    }
}

#Preview {
    CoinsListView()
        .environmentObject(CoinStore(repository: MockCoinRepository()))
}
