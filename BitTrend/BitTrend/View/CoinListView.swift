//
//  CoinsListView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct CoinsListView: View {
    
    enum Status {
        
        case loading, completed, failed
    }
    
    @StateObject private var store = CoinStore(repository: MockCoinRepository())
    @State private var state: Status = .loading
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                switch self.state {
                    
                case .loading:
                    ProgressView("Loading...")
                    
                case .failed:
                    ErrorView(action: self.fetchCoins)
                    
                case .completed:
                    List(self.store.coins) { coin in
                        
                        CoinRowView(coin: coin)
                    }
                }
            }
            .navigationTitle("BitTrend")
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

#Preview {
    CoinsListView()
}
