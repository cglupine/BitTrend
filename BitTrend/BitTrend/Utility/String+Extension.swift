//
//  String+Extension.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 03/02/25.
//

import Foundation

extension String {
 
    static func placeholder(length: Int) -> Self {
        
        .init(Array(repeating: "x", count: length))
    }
}
