//
//  CoinListMarketRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 09/02/25.
//

import Foundation

struct CoinListMarketRequest: JSONNetworkRequest {
    
    typealias ResponseDataType = [CoinListMarketDTO]
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDTO()
    let query: CoinListMarketQuery
    
    var absolutePath: String {
        
        AppData.baseURLString() + "/coins/markets"
    }
}

struct CoinListMarketQuery: Encodable {
    
    let vs_currency: String
    let per_page: Int
    let locale: String
    let precision: String
}

extension CoinListMarketRequest {
    
    enum Outcome: String {
        
        case success
        case empty
        case failure
    }
    
    class iMockURLProtocol: MockURLProtocol {
        
        static var outcome: Outcome = .success
        
        override func startLoading() {
            
            iMockURLProtocol.requestHandler = { request in
                
                switch Self.outcome {
                    
                case .failure:
                    throw URLError(.badServerResponse)

                default:
                    return try Self.localMockJsonResponseData(for: CoinListMarketRequest.self, resultSuffix: Self.outcome.rawValue)
                }
            }
            
            super.startLoading()
        }
    }
}
