//
//  CoinMarketCapView.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinMarketCapView: View {
    
    let coin: Coin
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(LK.marketCap.rawValue)
            
            HStack {
                Text(self.coin.marketCapPrice, format: .currency(code: "EUR"))
                    .font(.subheadline)
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
