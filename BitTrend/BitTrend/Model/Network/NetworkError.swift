//
//  NetworkError.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

enum NetworkError: Error, Equatable {
    
    case noInternetConnection
    case notFound
    case generic(code: URLError.Code)
}
