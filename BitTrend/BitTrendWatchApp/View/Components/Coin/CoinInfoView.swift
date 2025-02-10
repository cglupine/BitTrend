//
//  CoinInfoView.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinInfoView: View {
    
    let coin: Coin
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text(self.coin.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(self.coin.symbol.uppercased())
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    
                    RankView(value: self.coin.rank)
                        .padding(.leading, 4)
                }
                
                Text(self.coin.eurPrice, format: .currency(code: "EUR"))
                    .font(.title2)
                    .fontWeight(.bold)
                
                PercentageIndicator(value: self.coin.percentageChange)
            }
            
            Spacer()
        }
    }
}

#Preview {
    CoinInfoView(coin: .mockBitCoin())
}
