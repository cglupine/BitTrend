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
        
        GroupBox {
            
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 30))
                
                Text(LK.errorRetry.rawValue)
                    .font(.subheadline)
                
                Button(LK.retry.rawValue, action: self.action)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ErrorView() {}
}
