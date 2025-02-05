//
//  CoinDetailView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

extension CoinDetailView {
    
    enum ViewStatus {
        
        case loading, completed(CoinDetail), failed
    }
}

struct CoinDetailView: View {
    
    @Environment(\.openURL) private var openURL
    @Environment(CoinStore.self) private var store: CoinStore
    @State private var state: ViewStatus = .loading
    let coin: Coin
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                CoinImageView(coin: self.coin, size: 150, useThumbnail: false)
                
                CoinInfoView(coin: self.coin)
                
                switch self.state {
                    
                case .failed:
                    ErrorView(message: LK.errorRetry.rawValue, action: self.fetchDetails)

                case .loading:
                    self.detailView(for: nil)
                        .redacted(reason: .placeholder)
                    
                case .completed(let details):
                    self.detailView(for: details)
                }
                
                Spacer()
            }
            .padding()
            .transition(.opacity)
        }
        .onAppear(perform: self.fetchDetails)
        .onDisappear(perform: self.store.cancelDetailsFetching)
    }
    
    //MARK: - PRIVATE
    
    private func fetchDetails() {
        
        self.state = .loading
        
        Task {
            do {
                let details = try await self.store.loadDetailsTillLastWeek(forCoin: self.coin)
                withAnimation { self.state = .completed(details) }
                
            } catch {
                
                withAnimation { self.state = .failed }
            }
        }
    }
    
    @ViewBuilder private func detailView(for detail: CoinDetail?) -> some View {

        CoinChartBox(coin: self.coin, chartData: detail?.chartData)
        
        CoinDescriptionBox(detail: detail)
            .padding(.top)
    }
}

#Preview {
    CoinDetailView(coin: .mockBitCoin())
        .environment(
            CoinStore(repository: MockCoinRepository(
                reachabilityService: MockReachabilityService())
            )
        )
}
