//
//  RankView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import SwiftUI

struct RankView: View {
    
    let value: Int
    
    var body: some View {
        
        Text(verbatim: "#\(self.value)")
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    RankView(value: 145)
}
