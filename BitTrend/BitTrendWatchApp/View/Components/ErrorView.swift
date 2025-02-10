//
//  ErrorView.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct ErrorView: View {
    
    let message: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 30))
                
                Text(self.message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                
                Button(LK.retry.rawValue) {
                    
                    withAnimation { self.action() }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .transition(.scale(scale: 0.2).animation(.bouncy))
    }
}

#Preview {
    ErrorView(message: LK.errorRetry.rawValue) {}
}
