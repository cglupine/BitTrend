//
//  Text+Extension.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation
import SwiftUI

extension Text {
    
    init(htmlString: String, font: Font, foregroundColor: Color) {
        
        if let data = htmlString.data(using: .unicode),
           let attributed = try? NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil) {
            
            var result = AttributedString(attributed)
            result.font = font
            result.foregroundColor = foregroundColor
            
            self.init(result)
            
        } else {
            
            self.init(htmlString)
        }
    }
}
