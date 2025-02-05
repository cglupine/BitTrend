//
//  TrendingSearchListRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct TrendingSearchListRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDataType
    typealias QueryDataType = NetworkEmptyDataType
    typealias ResponseDataType = TrendDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDataType()
    let query = NetworkEmptyDataType()
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/search/trending"
    }
}
