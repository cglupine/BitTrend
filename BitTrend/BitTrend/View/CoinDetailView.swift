//
//  CoinDetailView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

extension CoinDetailView {
    
    enum ViewStatus {
        
        case loading, completed(CoinDetailViewModel), failed
    }
}

struct CoinDetailView: View {
    
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var store: CoinStore
    @State private var state: ViewStatus = .loading
    let coin: CoinViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                CoinImageView(coin: self.coin, size: 150, useThumbnail: false)
                
                CoinInfoView(coin: self.coin)
                
                switch self.state {
                    
                case .failed:
                    ErrorView(action: self.fetchDetails)

                case .loading:
                    self.detailView(for: nil)
                        .redacted(reason: .placeholder)
                    
                case .completed(let details):
                    self.detailView(for: details)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .task {
            self.fetchDetails()
        }
    }
    
    //MARK: - PRIVATE
    
    private func fetchDetails() {
        
        self.state = .loading
        
        Task {
            do {
                let details = try await self.store.loadDetails(forCoin: self.coin)
                self.state = .completed(details)
                
            } catch {
                
                self.state = .failed
            }
        }
    }
    
    @ViewBuilder private func detailView(for detail: CoinDetailViewModel?) -> some View {

        
        CoinDescriptionBox(detail: detail)
            .padding(.top)
    }
}

#Preview {
    CoinDetailView(coin: .mockBitCoin())
        .environmentObject(CoinStore(repository: MockCoinRepository()))
}
