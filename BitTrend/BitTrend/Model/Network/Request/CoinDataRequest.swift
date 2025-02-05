//
//  CoinDataRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct CoinDataRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDTO
    typealias QueryDataType = CoinDataQueryDTO
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
