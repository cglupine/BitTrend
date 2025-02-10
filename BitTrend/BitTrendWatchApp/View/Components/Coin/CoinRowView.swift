//
//  CoinRowView.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    
    var body: some View {
        
        HStack {
            
            VStack {
                
                CoinImageView(coin: self.coin, size: 50, useThumbnail: true)
    
                Text(self.coin.symbol.uppercased())
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
