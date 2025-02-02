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
            Text("Oops, an error occurred, please try again")
                .font(.subheadline)
            
            Button("RETRY", action: self.action)
                .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView() {}
}
