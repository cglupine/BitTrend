//
//  CoinInfoView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import SwiftUI

struct CoinInfoView: View {
    
    let coin: CoinViewModel
    
    var body: some View {
                
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                
                Text(self.coin.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Text(self.coin.symbol)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                RankView(value: self.coin.rank)
                    .padding(.leading, 4)
            }
            
            HStack(alignment: .firstTextBaseline) {
                Text(self.coin.eurPrice, format: .currency(code: "EUR"))
                    .font(.title)
                    .fontWeight(.bold)
                
                PercentageIndicator(value: self.coin.percentageChange)
                
                Spacer()
            }
        }
    }
}

#Preview {
    CoinInfoView(coin: .mockBitCoin())
}
