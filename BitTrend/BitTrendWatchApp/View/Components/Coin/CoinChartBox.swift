//
//  CoinChartBox.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinChartBox: View {
    
    let coin: Coin
    let chartData: [ChartEntry]?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(LK.lastWeek.rawValue)
                .font(.caption)
                .fontWeight(.thin)
            Text(LK.chart.rawValue)
            
            CoinChartView(coin: self.coin, data: self.chartData)
                .frame(height: 100)
                .unredacted()
                .accessibilityIdentifier("coinChart")
        }
        .padding(.top)
    }
}

#Preview {
    CoinChartBox(coin: .mockBitCoin(), chartData: ChartEntry.mock())
}
