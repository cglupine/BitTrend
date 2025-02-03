//
//  CoinDetailView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct CoinDetailView: View {
    
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var store: CoinStore
    @State private var state: ViewStatus = .loading
    let coin: CoinViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                CoinImageView(coin: self.coin, size: 150, useThumbnail: false)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    
                    Text(self.coin.name)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text(self.coin.symbol)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                Text(self.coin.eurPrice, format: .currency(code: "EUR"))
                    .font(.title)
                    .fontWeight(.bold)
                
                switch self.state {
                    
                case .loading:
                    ProgressView(LK.loading.rawValue)
                    
                case .failed:
                    ErrorView(action: self.fetchDetails)
                    
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
    
    @MainActor private func fetchDetails() {
        
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
    
    @ViewBuilder private func detailView(for detail: CoinDetailViewModel) -> some View {
        
        VStack {
            
            GroupBox(LK.description.rawValue) {
                
                Text(self.htmlDescription(for: detail.description))
                    .padding(.top, 8)
                
                HStack {
                 
                    Spacer()
                    
                    Link(destination: URL(string: detail.homepageURLString)!) {
                        
                        Label(LK.seeMore.rawValue, systemImage: "safari")
                            .font(.headline)
                    }
                }
                .padding(.top)
            }
            .padding(.top)
        }
    }
    
    @MainActor private func htmlDescription(for string: String) -> AttributedString {
        
        guard let nsAttributed = try? NSAttributedString(data: Data(string.utf8),
                                                         options: [.documentType: NSAttributedString.DocumentType.html],
                                                         documentAttributes: nil) else {
            
            return .init()
        }
        
        guard var result = try? AttributedString(nsAttributed, including: \.uiKit) else {
            
            return .init()
        }
        
        result.font = .body
        result.foregroundColor = .primary
        
        return result
    }
}

extension CoinDetailView {
    
    enum ViewStatus {
        
        case loading, completed(CoinDetailViewModel), failed
    }
}

#Preview {
    CoinDetailView(coin: .mockBitCoin())
        .environmentObject(CoinStore(repository: MockCoinRepository()))
}
