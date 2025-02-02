//
//  ErrorView.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 02/02/25.
//

import SwiftUI

struct ErrorView: View {
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(LK.errorRetry.rawValue)
                .font(.subheadline)
            
            Button(LK.retry.rawValue, action: self.action)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView() {}
}
