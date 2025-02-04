//
//  PercentageIndicator.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import SwiftUI

struct PercentageIndicator: View {
    
    let value: Double
    
    private var isBull: Bool { self.value > 0 }
    
    var body: some View {
        
        HStack(spacing: 2) {
            
            Image(systemName: "arrowtriangle.\(self.isBull ? "up" : "down").fill")
                .font(.system(size: 16))
            
            Text(self.value / 100,
                 format: .percent.precision(.fractionLength(2)))
            .font(.headline)
            .fontWeight(.medium)
        }
        .foregroundStyle(self.isBull ? .green : .red)
    }
}

#Preview {
    PercentageIndicator(value: -2.39)
}
