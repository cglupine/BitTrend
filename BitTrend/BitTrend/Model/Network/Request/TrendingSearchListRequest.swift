//
//  TrendingSearchListRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct TrendingSearchListRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDTO
    typealias QueryDataType = NetworkEmptyDTO
    typealias ResponseDataType = TrendDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDTO()
    let query = NetworkEmptyDTO()
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/search/trending"
    }
}

extension TrendingSearchListRequest {
    
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
                    return try Self.localMockJsonResponseData(for: TrendingSearchListRequest.self, resultSuffix: Self.outcome.rawValue)
                }
            }
            
            super.startLoading()
        }
    }
}
