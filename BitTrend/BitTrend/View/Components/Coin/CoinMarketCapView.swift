//
//  CoinMarketCapView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinMarketCapView: View {
    
    let coin: Coin
    
    var body: some View {
        
        GroupBox(LK.marketCap.rawValue) {
            
            HStack {
                Text(self.coin.marketCapPrice, format: .currency(code: "EUR"))
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding(.top, 4)
        }
        .padding(.top)
    }
}

#Preview {
    CoinMarketCapView(coin: .mockBitCoin())
}
