//
//  CoinDescriptionBox.swift
//  BitTrendWatchApp Watch App
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import SwiftUI

struct CoinDescriptionBox: View {
    
    let detail: CoinDetail?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if let description = self.detail?.description {
                
                Text(htmlString: description, font: .body, foregroundColor: .primary)
                    .padding(.top, 4)
                
            } else {
                
                Text(String.placeholder(length: 200))
                    .padding(.top, 4)
            }
            
            if let homepageURL = URL(string: self.detail?.homepageURLString ?? "") {
                
                HStack {
                    
                    Spacer()
                    
                    Link(destination: homepageURL) {
                        
                        Label(LK.seeMore.rawValue, systemImage: "safari")
                            .font(.headline)
                    }
                }
                .padding(.top)
                
            }
        }
    }
}

#Preview {
    CoinDescriptionBox(detail: nil)
}
