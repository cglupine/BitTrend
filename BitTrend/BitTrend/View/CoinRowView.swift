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
            
            AsyncImage(url: URL(string: self.coin.thumbnailURLString)) { image in
                
                image.resizable()
                
            } placeholder: {
                
                Image(systemName: "bitcoinsign.circle")
                    .font(.system(size: 50))
                    .foregroundStyle(.gray)
            }
            .frame(width: 50, height: 50)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
             
                Text(self.coin.name)
                Text(self.coin.symbol)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text("\(self.coin.ranking)")
        }
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        
        CoinRowView(coin: .bitcoin())
            .padding()
    }
}
