//
//  URLResponseValidator.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct URLResponseValidator {
    
    static func validateURLResponse(_ response: HTTPURLResponse) throws {
        
        switch response.statusCode {
            
        case 200..<300:
            return
            
        case 404:
            throw NetworkError.notFound
            
        case URLError.notConnectedToInternet.rawValue:
            throw NetworkError.noInternetConnection
            
        default:
            throw NetworkError.generic(code: .init(rawValue: response.statusCode))
        }
    }
}
