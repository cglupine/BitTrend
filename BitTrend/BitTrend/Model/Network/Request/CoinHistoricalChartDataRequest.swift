//
//  CoinHistoricalChartDataRequest.swift
//  BitTrend
//
//  Created by Gabriele Carbutto on 04/02/25.
//

import Foundation

struct CoinHistoricalChartDataRequest: JSONNetworkRequest {
    
    typealias HeadersDataType = NetworkEmptyDTO
    typealias QueryDataType = CoinHistoricalChartDataQueryDTO
    typealias ResponseDataType = ChartDTO
    
    let method: HTTPMethod = .GET
    let headers = NetworkEmptyDTO()
    let id: String
    let query: CoinHistoricalChartDataQueryDTO
    
    var absolutePath: String {
       
        AppData.baseURLString() + "/coins/\(id)/market_chart"
    }
}

struct CoinHistoricalChartDataQueryDTO: Encodable {
    
    let vs_currency: String
    let days: Int
    let precision: Int
}
