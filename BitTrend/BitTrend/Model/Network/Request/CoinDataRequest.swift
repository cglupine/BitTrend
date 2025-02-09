//
//  CoinDataRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct CoinDataRequest: JSONNetworkRequest {
    
    typealias ResponseDataType = CoinDetailDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDTO()
    let query = CoinDataQueryDTO()
    let id: String
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/coins/\(id)"
    }
}

struct CoinDataQueryDTO: Encodable {
    
    let tickers = false
    let community_data = false
    let developer_data = false
}

extension CoinDataRequest {
    
    enum Outcome: String {
        
        case success
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
                    return try Self.localMockJsonResponseData(for: CoinDataRequest.self, resultSuffix: Self.outcome.rawValue)
                }
            }
            
            super.startLoading()
        }
    }
}
