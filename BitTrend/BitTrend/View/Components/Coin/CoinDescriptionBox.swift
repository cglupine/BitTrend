//
//  CoinDescriptionBox.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import SwiftUI

struct CoinDescriptionBox: View {
    
    let detail: CoinDetailViewModel?
    
    var body: some View {
        
        GroupBox(LK.description.rawValue) {
            
            if let description = self.detail?.description {
                
                Text(htmlString: description, font: .body, foregroundColor: .primary)
                    .padding(.top, 4)
                
            } else {
                
                Text(String.placeholder(length: 200))
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
