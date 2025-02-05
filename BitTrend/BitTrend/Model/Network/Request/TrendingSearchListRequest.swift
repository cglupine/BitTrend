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
