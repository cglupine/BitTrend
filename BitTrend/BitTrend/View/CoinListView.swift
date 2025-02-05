//
//  CoinsListView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

extension CoinsListView {
    
    enum ViewStatus: Equatable {
        
        case loading, completed, failed(LocalizedStringKey)
    }
}

struct CoinsListView: View {
    
    @Environment(CoinStore.self) private var store: CoinStore
    @State private var state: ViewStatus = .loading
    
    private var isLoading: Bool { self.state == .loading }
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                switch self.state {
                    
                case .failed(let message):
                    ErrorView(message: message, action: self.fetchCoins)
                    
                default:
                    if !self.isLoading, self.store.coins.isEmpty {
                        
                        ErrorView(message: LK.noData.rawValue, action: self.fetchCoins)
                        
                    } else {
                        
                        List(self.isLoading ? .skeleton(size: 10) : self.store.coins) { coin in
                            
                            NavigationLink(destination: CoinDetailView(coin: coin)) {
                                
                                CoinRowView(coin: coin)
                                    .redacted(reason: (self.isLoading ? .placeholder : []))
                            }
                            .disabled(self.isLoading)
                        }
                    }
                }
            }
            .navigationTitle(LK.topTenCoins.rawValue)
            .transition(.opacity)
        }
        .onAppear(perform: self.fetchCoins)
    }
    
    //MARK: - PRIVATE
    
    private func fetchCoins() {
        
        self.state = .loading
        
        Task {
            do {
                try await self.store.loadTopTenCoins()
                withAnimation { self.state = .completed }
                
            } catch NetworkError.noInternetConnection {
                
                withAnimation { self.state = .failed(LK.errorConnectivity.rawValue) }
                
            } catch {
                
                withAnimation { self.state = .failed(LK.errorRetry.rawValue) }
            }
        }
    }
}

#Preview {
    CoinsListView()
        .environment(
            CoinStore(repository: MockCoinRepository(
                reachabilityService: MockReachabilityService())
            )
        )
}
