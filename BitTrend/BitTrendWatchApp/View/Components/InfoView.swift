//
//  InfoView.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct InfoView: View {
    
    let message: LocalizedStringKey
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
         
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 30))
                
                Text(self.message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    InfoView(message: LK.errorRetry.rawValue)
}
