//
//  CoinRowView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinViewModel
    
    var body: some View {
        
        HStack {
            
            CoinImageView(coin: self.coin, size: 50, useThumbnail: true)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
             
                Text(self.coin.name)
                Text(self.coin.symbol)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text(self.coin.eurPrice, format: .currency(code: "EUR"))
                .font(.caption)
        }
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        
        CoinRowView(coin: .mockBitCoin())
            .padding()
    }
}
