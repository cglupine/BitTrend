//
//  CoinChartView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 03/02/25.
//

import SwiftUI
import Charts

struct CoinChartView: View {
    
    let coin: Coin
    let data: [ChartEntry]?
    
    var body: some View {
        
        if let data {
            
            Chart {
                ForEach(data) { entry in
                    LineMark(x: .value(LK.chartDay.rawValue, entry.date),
                             y: .value(LK.chartPrice.rawValue, entry.amount))
                    .lineStyle(.init(lineWidth: 3, lineJoin: .round))
                    
                    AreaMark(x: .value(LK.chartDay.rawValue, entry.date),
                             yStart: .value(LK.chartPrice.rawValue, entry.amount),
                             yEnd: .value(LK.chartPrice.rawValue, self.yScaleDomainRange().lowerBound))
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient (
                            colors: [
                                Color.accentColor.opacity(0.5),
                                Color.accentColor.opacity(0.05),
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.day(), centered: true)
                }
            }
            .chartYAxis {
                AxisMarks {
                    AxisValueLabel(format: .currency(code: "eur").notation(.compactName))
                }
            }
            .chartYScale(domain: yScaleDomainRange())
            .chartLegend(.hidden)
            
        } else {
            
            Image(systemName: "chart.xyaxis.line")
                .font(.system(size: 60))
                .foregroundStyle(.tertiary)
        }
    }
    
    //MARK: - PRIVATE
    
    private func yScaleDomainRange() -> ClosedRange<Double> {
        
        let values = self.data?.compactMap { $0.amount }
        let min = values?.min() ?? .zero
        let max = values?.max() ?? .zero
        
        return min...max
    }
}

#Preview {
    CoinChartView(coin: .mockBitCoin(), data: ChartEntry.mock())
        .frame(height: 100)
}
