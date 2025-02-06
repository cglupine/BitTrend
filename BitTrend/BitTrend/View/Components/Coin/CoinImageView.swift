//
//  CoinImageView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct CoinImageView: View {
    
    let coin: Coin
    let size: CGFloat
    let useThumbnail: Bool
    
    var body: some View {
        
        AsyncImage(url: self.imageURL) { image in
            
            image.resizable()
            
        } placeholder: {
            
            Image(systemName: "bitcoinsign.circle")
                .resizable()
                .font(.system(size: self.size))
                .foregroundStyle(.gray)
        }
        .frame(width: self.size, height: self.size)
    }
    
    //MARK: - PRIVATE
    
    private var imageURL: URL? {
        
        if self.useThumbnail {
            
            return URL(string: self.coin.thumbnailURLString)
            
        } else {
            
            return URL(string: self.coin.largeImageURLString)
        }
    }
}

#Preview {
    CoinImageView(coin: .mockBitCoin(), size: 90, useThumbnail: false)
}
