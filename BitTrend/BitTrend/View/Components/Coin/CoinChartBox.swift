//
//  CoinChartBox.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import SwiftUI

struct CoinChartBox: View {
    
    let coin: Coin
    let chartData: [ChartEntry]?
    
    var body: some View {
        GroupBox {
            
            CoinChartView(coin: self.coin, data: self.chartData)
                .frame(height: 100)
                .unredacted()
                .accessibilityIdentifier("coinChart")
            
        } label: {
            
            Text(LK.lastWeek.rawValue)
                .font(.caption)
                .fontWeight(.thin)
            Text(LK.chart.rawValue)
        }
        .padding(.top)
    }
}

#Preview {
    CoinChartBox(coin: .mockBitCoin(), chartData: ChartEntry.mock())
}
